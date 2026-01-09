/* POSIX stubs for OCaml 5 on bare-metal Pico 2 W
 *
 * Provides pthread, mmap, and other POSIX APIs needed by OCaml's multicore
 * runtime on bare-metal ARM Cortex-M33. Key features:
 * - Dual-core support via Pico SDK multicore API
 * - Stop-the-world GC interrupt handling
 * - Thread-safe heap allocation (malloc/sbrk)
 * - Condition variables for Domain synchronization
 */

#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>
#include <signal.h>
#include <locale.h>

/* Pico SDK multicore support */
#include "pico/multicore.h"
#include "pico/mutex.h"
#include "pico/stdio.h"
#include "hardware/sync.h"

/* Forward declarations for raw output */
void raw_puts_unsafe(const char *s);
void raw_putint_unsafe(int n);

/* Hard fault handler */
void HardFault_Handler(void) {
    volatile uint32_t *uart_dr = (volatile uint32_t *)0x40034000;
    const char *msg = "\n!!! HARD FAULT !!!\n";
    while (*msg) { *uart_dr = *msg++; for(volatile int i=0;i<10000;i++); }
    while(1) __asm__("wfi");
}

typedef uintptr_t uintnat;
typedef pthread_mutex_t caml_plat_mutex;
typedef pthread_cond_t caml_plat_cond;
#include "ocaml_stubs.h"

/* ============================================================
 * STW (Stop-The-World) GC interrupt handling
 * OCaml's multicore GC requires all domains to synchronize. On bare
 * metal we poll for interrupts in blocking operations (mutex, condvar).
 * ============================================================ */

extern int caml_incoming_interrupts_queued(void);
extern void caml_handle_incoming_interrupts(void);
extern pthread_mutex_t *caml_get_domain_lock(void);
extern _Thread_local void* caml_state;
extern void* caml_get_domain_state(void);
extern void caml_reset_backup_thread_state(void);

/* Per-core reentrancy guard - prevent nested STW handling */
static volatile int handling_stw[2] = {0, 0};

/* Track calls to pthread_create */
static int pthread_create_count = 0;

static int try_handle_stw_interrupt(void) {
    int core = (*(volatile unsigned int *)0xd0000000) & 1;

    /* Prevent reentrancy - if we're already handling STW, don't nest */
    if (handling_stw[core]) {
        return 0;
    }

    /* First check: is the interrupt actually queued? */
    if (caml_incoming_interrupts_queued()) {
        pthread_mutex_t *domain_lock = caml_get_domain_lock();
        if (domain_lock && pthread_mutex_trylock(domain_lock) == 0) {
            handling_stw[core] = 1;
            /* CRITICAL: Must set caml_state before handling interrupts!
               The backup thread does this - we must too. */
            void *saved_state = caml_state;
            caml_state = caml_get_domain_state();
            caml_handle_incoming_interrupts();
            caml_state = saved_state;  /* Restore - we're still in blocking section */
            handling_stw[core] = 0;
            pthread_mutex_unlock(domain_lock);
            return 1;
        }
    }
    return 0;
}

/* ============================================================
 * Newlib syscall stubs for bare-metal I/O
 * ============================================================ */
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

/* _write - called by newlib for stdout/stderr */
int _write(int fd, const char *buf, int count) {
    if (fd == 1 || fd == 2) {
        for (int i = 0; i < count; i++) {
            putchar(buf[i]);
            /* Check for STW periodically while printing */
            if ((i & 0x1F) == 0) {
                try_handle_stw_interrupt();
            }
        }
        return count;
    }
    errno = EBADF;
    return -1;
}

/* _read - called for stdin, return EOF */
int _read(int fd, char *buf, int count) {
    (void)buf; (void)count;
    if (fd == 0) {  /* stdin - no input available */
        return 0;   /* EOF */
    }
    errno = EBADF;
    return -1;
}

/* _lseek - not supported for console I/O */
int _lseek(int fd, int offset, int whence) {
    (void)fd; (void)offset; (void)whence;
    errno = ESPIPE;  /* Illegal seek */
    return -1;
}

/* _fstat - return character device for stdin/stdout/stderr */
int _fstat(int fd, struct stat *st) {
    if (fd >= 0 && fd <= 2) {
        memset(st, 0, sizeof(*st));
        st->st_mode = S_IFCHR;  /* Character device */
        return 0;
    }
    errno = EBADF;
    return -1;
}

/* _isatty - stdin/stdout/stderr are terminals */
int _isatty(int fd) {
    return (fd >= 0 && fd <= 2) ? 1 : 0;
}

/* _close - pretend success for std fds */
int _close(int fd) {
    if (fd >= 0 && fd <= 2) {
        return 0;  /* Can't really close std fds */
    }
    errno = EBADF;
    return -1;
}

/* Custom _sbrk for bare-metal heap management */
extern char __end__;       /* End of BSS, start of heap */
extern char __HeapLimit;   /* End of heap (before stack) */
static char *heap_ptr = NULL;

/* Mutex to protect sbrk from concurrent access by both cores */
static mutex_t sbrk_mutex;
static bool sbrk_mutex_initialized = false;

void init_sbrk_mutex(void) {
    mutex_init(&sbrk_mutex);
    sbrk_mutex_initialized = true;
}

void *_sbrk(ptrdiff_t incr) {
    /* Take lock if initialized (may be called before main) */
    if (sbrk_mutex_initialized) {
        mutex_enter_blocking(&sbrk_mutex);
    }

    if (heap_ptr == NULL) {
        heap_ptr = &__end__;
    }

    char *prev_heap = heap_ptr;
    char *new_heap = heap_ptr + incr;

    if (new_heap > &__HeapLimit) {
        if (sbrk_mutex_initialized) {
            mutex_exit(&sbrk_mutex);
        }
        raw_puts_unsafe("\n!!! OOM need=");
        raw_putint_unsafe((int)incr);
        raw_puts_unsafe(" used=");
        raw_putint_unsafe((int)(heap_ptr - &__end__));
        raw_puts_unsafe(" !!!\n");
        errno = ENOMEM;
        return (void *)-1;
    }

    heap_ptr = new_heap;

    if (sbrk_mutex_initialized) {
        mutex_exit(&sbrk_mutex);
    }
    return prev_heap;
}

#include <stdatomic.h>

/* Thread-local storage - per-core (not static for ASM access) */
char tls_area_core0[256] __attribute__((aligned(8)));
char tls_area_core1[256] __attribute__((aligned(8)));

/* Pure assembly implementation to avoid any C conditionals */
__attribute__((naked)) void *__aeabi_read_tp(void) {
    __asm__ volatile (
        "ldr r0, =0xd0000000\n"  /* SIO base */
        "ldr r0, [r0]\n"         /* Read CPUID (0 or 1) */
        "cmp r0, #0\n"
        "beq 1f\n"
        "ldr r0, =tls_area_core1\n"
        "bx lr\n"
        "1:\n"
        "ldr r0, =tls_area_core0\n"
        "bx lr\n"
    );
}

/* Recursive mutex implementation using Pico SDK */
#define MAX_MUTEXES 64
#define MUTEX_MAGIC 0x4D555458
typedef struct { uint32_t magic; recursive_mutex_t mtx; } pico_mutex_entry_t;
static pico_mutex_entry_t mutex_storage[MAX_MUTEXES];
static volatile int mutex_count = 0;

/* Per-core tracking of held mutexes (for cleanup on cond_wait) */
static volatile uint64_t held_mutexes[2] = {0, 0};  /* Bitmask for each core */
static volatile int held_counts[2][MAX_MUTEXES] = {{0}};  /* Lock count per mutex per core */

static int ensure_mutex_init(pthread_mutex_t *m) {
    int idx = *(int*)m;
    if (idx < 0 || idx >= MAX_MUTEXES || mutex_storage[idx].magic != MUTEX_MAGIC) {
        if (mutex_count >= MAX_MUTEXES) return -1;
        idx = mutex_count++;
        recursive_mutex_init(&mutex_storage[idx].mtx);
        mutex_storage[idx].magic = MUTEX_MAGIC;
        *(int*)m = idx;
    }
    return idx;
}

int pthread_mutex_init(pthread_mutex_t *m, const pthread_mutexattr_t *a) {
    (void)a;
    if (mutex_count >= MAX_MUTEXES) return ENOMEM;
    int idx = mutex_count++;
    recursive_mutex_init(&mutex_storage[idx].mtx);
    mutex_storage[idx].magic = MUTEX_MAGIC;
    *(int*)m = idx;
    return 0;
}
int pthread_mutex_destroy(pthread_mutex_t *m) { (void)m; return 0; }

int pthread_mutex_lock(pthread_mutex_t *m) {
    int idx = ensure_mutex_init(m);
    int core = (*(volatile unsigned int *)0xd0000000) & 1;

    if (idx >= 0) {
        /* Use try_lock with STW handling instead of blocking lock */
        while (!recursive_mutex_try_enter(&mutex_storage[idx].mtx, NULL)) {
            try_handle_stw_interrupt();
            sleep_us(50);
        }
        /* Track this mutex as held by this core */
        held_mutexes[core] |= (1ULL << idx);
        held_counts[core][idx]++;
    }
    return 0;
}
int pthread_mutex_trylock(pthread_mutex_t *m) {
    int idx = ensure_mutex_init(m);
    int core = (*(volatile unsigned int *)0xd0000000) & 1;

    if (idx >= 0) {
        bool got = recursive_mutex_try_enter(&mutex_storage[idx].mtx, NULL);
        if (got) {
            held_mutexes[core] |= (1ULL << idx);
            held_counts[core][idx]++;
        }
        return got ? 0 : EBUSY;
    }
    return EINVAL;
}

int pthread_mutex_unlock(pthread_mutex_t *m) {
    int idx = *(int*)m;
    int core = (*(volatile unsigned int *)0xd0000000) & 1;

    if (idx >= 0 && idx < MAX_MUTEXES && mutex_storage[idx].magic == MUTEX_MAGIC) {
        recursive_mutex_exit(&mutex_storage[idx].mtx);
        /* Update tracking */
        if (held_counts[core][idx] > 0) {
            held_counts[core][idx]--;
            if (held_counts[core][idx] == 0) {
                held_mutexes[core] &= ~(1ULL << idx);
            }
        }
    }
    return 0;
}
int pthread_mutexattr_init(pthread_mutexattr_t *a) { (void)a; return 0; }
int pthread_mutexattr_destroy(pthread_mutexattr_t *a) { (void)a; return 0; }
int pthread_mutexattr_settype(pthread_mutexattr_t *a, int type) { (void)a; (void)type; return 0; }

/* ============================================================
 * Newlib malloc lock for multicore safety
 * ============================================================ */
#include <reent.h>
static recursive_mutex_t malloc_mutex;
static volatile bool malloc_mutex_initialized = false;

/* Call this early from main() before any threads */
void init_malloc_mutex(void) {
    if (!malloc_mutex_initialized) {
        recursive_mutex_init(&malloc_mutex);
        malloc_mutex_initialized = true;
    }
}

void __malloc_lock(struct _reent *r) {
    (void)r;
    /* Should already be initialized by init_malloc_mutex() */
    if (!malloc_mutex_initialized) {
        recursive_mutex_init(&malloc_mutex);
        malloc_mutex_initialized = true;
    }
    recursive_mutex_enter_blocking(&malloc_mutex);
}

void __malloc_unlock(struct _reent *r) {
    (void)r;
    if (malloc_mutex_initialized) {
        recursive_mutex_exit(&malloc_mutex);
    }
}

/* Real condition variable using generation counter */
#define MAX_CONDVARS 64
#define CONDVAR_MAGIC 0x434F4E44
typedef struct {
    uint32_t magic;
    mutex_t lock;
    volatile int waiters;
    volatile int generation;
} pico_condvar_t;
static pico_condvar_t condvar_storage[MAX_CONDVARS];
static volatile int condvar_count = 0;

static int ensure_condvar_init(pthread_cond_t *c) {
    int idx = *(int*)c;
    if (idx < 0 || idx >= MAX_CONDVARS || condvar_storage[idx].magic != CONDVAR_MAGIC) {
        if (condvar_count >= MAX_CONDVARS) return -1;
        idx = condvar_count++;
        mutex_init(&condvar_storage[idx].lock);
        condvar_storage[idx].waiters = 0;
        condvar_storage[idx].generation = 0;
        condvar_storage[idx].magic = CONDVAR_MAGIC;
        *(int*)c = idx;
    }
    return idx;
}

int pthread_cond_init(pthread_cond_t *c, const pthread_condattr_t *a) {
    (void)a;
    if (condvar_count >= MAX_CONDVARS) return ENOMEM;
    int idx = condvar_count++;
    mutex_init(&condvar_storage[idx].lock);
    condvar_storage[idx].waiters = 0;
    condvar_storage[idx].generation = 0;
    condvar_storage[idx].magic = CONDVAR_MAGIC;
    *(int*)c = idx;
    return 0;
}
int pthread_cond_destroy(pthread_cond_t *c) { (void)c; return 0; }

/* Raw output functions with spinlock to serialize between cores */
static volatile uint32_t raw_output_lock = 0;
void raw_lock(void) {
    while (__atomic_test_and_set(&raw_output_lock, __ATOMIC_ACQUIRE)) {
        __wfe();
    }
}
void raw_unlock(void) {
    __atomic_clear(&raw_output_lock, __ATOMIC_RELEASE);
    __sev();
}
static void raw_putchar(char c) {
    putchar_raw(c);
}
void raw_puts(const char *s) {
    raw_lock();
    while (*s) raw_putchar(*s++);
    raw_unlock();
}
/* Emergency output - no locking, for timeout/crash handlers */
void raw_puts_unsafe(const char *s) {
    while (*s) { putchar_raw(*s++); for(volatile int d=0;d<1000;d++); }
}
void raw_putint_unsafe(int n) {
    char buf[12];
    int i = 0;
    if (n < 0) { putchar_raw('-'); n = -n; }
    if (n == 0) { putchar_raw('0'); return; }
    while (n > 0) { buf[i++] = '0' + (n % 10); n /= 10; }
    while (i > 0) { putchar_raw(buf[--i]); for(volatile int d=0;d<1000;d++); }
}
void raw_puthex_unsafe(unsigned int n) {
    static const char hex[] = "0123456789abcdef";
    putchar_raw('0'); putchar_raw('x');
    for (int i = 28; i >= 0; i -= 4) {
        putchar_raw(hex[(n >> i) & 0xf]);
        for(volatile int d=0;d<500;d++);
    }
}
void raw_putint(int n) {
    char buf[12];
    int i = 0;
    raw_lock();
    if (n < 0) { raw_putchar('-'); n = -n; }
    if (n == 0) { raw_putchar('0'); raw_unlock(); return; }
    while (n > 0) { buf[i++] = '0' + (n % 10); n /= 10; }
    while (i > 0) raw_putchar(buf[--i]);
    raw_unlock();
}

int pthread_cond_wait(pthread_cond_t *c, pthread_mutex_t *m) {
    int idx = ensure_condvar_init(c);
    if (idx < 0) return EINVAL;
    pico_condvar_t *cv = &condvar_storage[idx];

    int core = (*(volatile unsigned int *)0xd0000000) & 1;
    int mutex_idx = *(int*)m;

    /* POSIX: Only release the passed mutex, not all held mutexes */

    /* Take cv lock to update waiters */
    mutex_enter_blocking(&cv->lock);
    int my_gen = cv->generation;
    cv->waiters++;
    mutex_exit(&cv->lock);

    /* Release ONLY the passed mutex (POSIX behavior) */
    if (mutex_idx >= 0 && mutex_idx < MAX_MUTEXES && mutex_storage[mutex_idx].magic == MUTEX_MAGIC) {
        recursive_mutex_exit(&mutex_storage[mutex_idx].mtx);
        if (held_counts[core][mutex_idx] > 0) held_counts[core][mutex_idx]--;
        if (held_counts[core][mutex_idx] == 0) held_mutexes[core] &= ~(1ULL << mutex_idx);
    }
    __dmb();
    __sev();

    int loops = 0;
    while (1) {
        __dmb();  /* Memory barrier before checking */
        /* Simple volatile read - no locking */
        if (cv->generation != my_gen) {
            __dsb();  /* CRITICAL: Ensure we see ALL writes from signaling thread */
            mutex_enter_blocking(&cv->lock);
            cv->waiters--;
            mutex_exit(&cv->lock);
            break;
        }
        /* Check for STW interrupts while waiting - emulate backup thread */
        if (loops % 100 == 0) {
            try_handle_stw_interrupt();
        }
        sleep_us(100);
        loops++;
        if (loops > 100000) loops = 1;  /* Prevent overflow, keep waiting */
    }

    /* POSIX: Reacquire only the passed mutex, with STW handling */
    if (mutex_idx >= 0 && mutex_idx < MAX_MUTEXES && mutex_storage[mutex_idx].magic == MUTEX_MAGIC) {
        /* Try to acquire mutex, handling STW interrupts while waiting.
           This is critical: the mutex may be held by a domain trying to
           do STW, which needs us to participate before it releases. */
        uint32_t owner_out;
        while (!recursive_mutex_try_enter(&mutex_storage[mutex_idx].mtx, &owner_out)) {
            try_handle_stw_interrupt();
            sleep_us(100);
        }
        held_mutexes[core] |= (1ULL << mutex_idx);
        held_counts[core][mutex_idx]++;
    }

    return 0;
}
int pthread_cond_signal(pthread_cond_t *c) {
    int idx = ensure_condvar_init(c);
    if (idx < 0) return 0;
    pico_condvar_t *cv = &condvar_storage[idx];

    mutex_enter_blocking(&cv->lock);
    __dsb();  /* CRITICAL: Ensure ALL previous writes are visible to other cores */
    if (cv->waiters > 0) cv->generation++;
    mutex_exit(&cv->lock);
    __sev();  /* Wake sleeping cores */
    return 0;
}
int pthread_cond_broadcast(pthread_cond_t *c) {
    int idx = ensure_condvar_init(c);
    if (idx < 0) return 0;
    pico_condvar_t *cv = &condvar_storage[idx];
    mutex_enter_blocking(&cv->lock);
    __dsb();  /* CRITICAL: Ensure ALL previous writes are visible to other cores */
    cv->generation++;
    mutex_exit(&cv->lock);
    __sev();  /* Wake sleeping cores */
    return 0;
}
int pthread_condattr_init(pthread_condattr_t *a) { (void)a; return 0; }
int pthread_condattr_destroy(pthread_condattr_t *a) { (void)a; return 0; }
int pthread_condattr_setclock(pthread_condattr_t *a, int c) { (void)a; (void)c; return 0; }

/* Thread management with multicore support */

/* SIO CPUID for raw core number */
#define SIO_CPUID (*(volatile unsigned int *)0xd0000000)

pthread_t pthread_self(void) { return (SIO_CPUID & 1) + 1; }
int pthread_equal(pthread_t t1, pthread_t t2) { return t1 == t2; }

/* Core 1 launch support */
static void *(*core1_entry_func)(void*) = NULL;
static void *core1_entry_arg = NULL;
static volatile int core1_started = 0;
static volatile int core1_finished = 0;

/* Stack for core 1 */
#define CORE1_STACK_SIZE (16 * 1024)
static uint32_t core1_stack[CORE1_STACK_SIZE / sizeof(uint32_t)];

/* Per-core TLS key storage - declared early for use in pthread_create */
#define MAX_TLS_KEYS 16
static void *tls_values[2][MAX_TLS_KEYS];

static void core1_wrapper(void) {
    __dmb();
    core1_started = 1;
    core1_finished = 0;
    /* No printf here - runs on core 1, causes issues */
    core1_entry_func(core1_entry_arg);

    /* Cleanup: release any mutexes still held by core 1 */
    for (int i = 0; i < MAX_MUTEXES; i++) {
        while (held_counts[1][i] > 0) {
            recursive_mutex_exit(&mutex_storage[i].mtx);
            held_counts[1][i]--;
        }
    }
    held_mutexes[1] = 0;

    /* Reset backup thread state so next domain can spawn on this core */
    caml_reset_backup_thread_state();

    core1_finished = 1;
    __dmb();
    while(1) __wfi();
}

int pthread_create(pthread_t *t, const pthread_attr_t *a, void*(*f)(void*), void *arg) {
    (void)a;
    pthread_create_count++;

    /* Pattern: odd calls are backup threads (skip), even calls are domain threads (launch core 1)
       Call 1: backup thread for domain 0 - skip
       Call 2: domain thread - launch core 1
       Call 3: backup thread for domain 1 - skip
       Call 4: domain thread - relaunch core 1
       etc. */
    if (pthread_create_count % 2 == 1) {
        /* Odd call: backup thread - fake it */
        *t = 100 + pthread_create_count;
        return 0;
    }

    /* Even call: domain thread - launch on core 1 */
    core1_entry_func = f;
    core1_entry_arg = arg;
    core1_started = 0;
    __dmb();

    /* If core 1 was previously launched, wait for cleanup then reset */
    if (pthread_create_count > 2) {
        /* Wait for previous domain's cleanup to complete */
        while (!core1_finished) {
            sleep_ms(1);
        }
        multicore_reset_core1();
        sleep_ms(1);  /* Brief delay for reset to complete */
        /* Clear TLS for core1 */
        for (int i = 0; i < MAX_TLS_KEYS; i++) {
            tls_values[1][i] = NULL;
        }
    }

    multicore_launch_core1_with_stack(core1_wrapper, core1_stack, CORE1_STACK_SIZE);
    while (!core1_started) tight_loop_contents();

    *t = 2;
    return 0;
}
int pthread_join(pthread_t t, void **retval) {
    (void)retval;
    /* Thread 2 is the domain thread on core 1 */
    if (t == 2) {
        while (!core1_finished) {
            sleep_ms(10);
        }
        /* Brief extra delay to ensure cleanup fully completes */
        sleep_ms(10);
    }
    /* Backup threads (100+) don't need real join */
    return 0;
}
int pthread_detach(pthread_t t) { (void)t; return 0; }
void pthread_exit(void *retval) { (void)retval; while(1) __wfi(); }
int pthread_cancel(pthread_t t) { (void)t; return -1; }

/* TLS key management (tls_values defined earlier) */
static pthread_key_t next_tls_key = 0;

int pthread_key_create(pthread_key_t *key, void (*destructor)(void*)) {
    (void)destructor;
    if (next_tls_key >= MAX_TLS_KEYS) return EAGAIN;
    *key = next_tls_key++;
    return 0;
}
int pthread_key_delete(pthread_key_t key) { (void)key; return 0; }
void *pthread_getspecific(pthread_key_t key) {
    if (key >= MAX_TLS_KEYS) return NULL;
    return tls_values[SIO_CPUID & 1][key];
}
int pthread_setspecific(pthread_key_t key, const void *value) {
    if (key >= MAX_TLS_KEYS) return EINVAL;
    tls_values[SIO_CPUID & 1][key] = (void*)value;
    return 0;
}
int pthread_getaffinity_np(pthread_t t, size_t s, cpu_set_t *c) {
    (void)t; (void)s; (void)c; return -1;
}

/* posix_memalign stub */
int posix_memalign(void **memptr, size_t alignment, size_t size) {
    if (alignment < sizeof(void*)) alignment = sizeof(void*);
    void *raw = malloc(size + alignment + sizeof(void*));
    if (!raw) {
        return ENOMEM;
    }
    uintptr_t addr = (uintptr_t)raw + sizeof(void*);
    addr = (addr + alignment - 1) & ~(alignment - 1);
    ((void**)addr)[-1] = raw;
    *memptr = (void*)addr;
    return 0;
}

/* mmap stubs - use sbrk bump allocator (no free, suitable for OCaml heaps) */
#include <sys/mman.h>
void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset) {
    (void)prot; (void)fd; (void)offset;

    if (addr != NULL && (flags & MAP_FIXED)) {
        return addr;
    }
    /* Use sbrk directly - zero overhead bump allocator */
    /* Round up to 8-byte alignment */
    length = (length + 7) & ~7;
    void *p = sbrk(length);
    if (p != (void*)-1) {
        memset(p, 0, length);  /* mmap returns zeroed memory */
        return p;
    }
    return MAP_FAILED;
}

int munmap(void *addr, size_t length) {
    (void)addr; (void)length;
    /* Bump allocator doesn't free - OCaml minor heaps are long-lived anyway */
    return 0;
}

int mprotect(void *addr, size_t len, int prot) {
    (void)addr; (void)len; (void)prot;
    return 0;
}

/* nanosleep stub - use Pico SDK sleep */
#include <time.h>
#include "pico/stdlib.h"
int nanosleep(const struct timespec *req, struct timespec *rem) {
    if (req) {
        uint32_t ms = req->tv_sec * 1000 + req->tv_nsec / 1000000;
        if (ms > 0) sleep_ms(ms);
    }
    if (rem) {
        rem->tv_sec = 0;
        rem->tv_nsec = 0;
    }
    return 0;
}

/* Process stubs */
#include <sys/time.h>
#include <sys/resource.h>

int getpid(void) { return 1; }
int getppid(void) { return 0; }
int getrusage(int who, struct rusage *usage) {
    (void)who;
    if (usage) memset(usage, 0, sizeof(*usage));
    return 0;
}
int gettimeofday(struct timeval *tv, void *tz) {
    (void)tz;
    if (tv) {
        uint64_t us = time_us_64(); /* Pico SDK microseconds */
        tv->tv_sec = us / 1000000;
        tv->tv_usec = us % 1000000;
    }
    return 0;
}

/* Entropy stub */
int getentropy(void *buf, size_t len) {
    unsigned char *p = buf;
    for (size_t i = 0; i < len; i++) {
        p[i] = (unsigned char)(i * 17 + 42);
    }
    return 0;
}

/* Signal stubs */
int sigaction(int sig, const struct sigaction *act, struct sigaction *oact) {
    (void)sig; (void)act; (void)oact;
    return 0;
}

int sigaltstack(const stack_t *ss, stack_t *old_ss) {
    (void)ss; (void)old_ss;
    return 0;
}

int pthread_sigmask(int how, const sigset_t *set, sigset_t *oldset) {
    (void)how; (void)set; (void)oldset;
    return 0;
}

/* System stubs */
#include <unistd.h>
long sysconf(int name) {
    switch (name) {
        case _SC_PAGESIZE: return 4096;
        case _SC_NPROCESSORS_ONLN: return 2;
        case _SC_NPROCESSORS_CONF: return 2;
        default: return -1;
    }
}

/* Runtime events stubs - profiling/tracing not supported */
void caml_ev_begin(int ev) { (void)ev; }
void caml_ev_end(int ev) { (void)ev; }
void caml_ev_counter(int ev, unsigned long val) { (void)ev; (void)val; }
void caml_ev_lifecycle(int ev, int data) { (void)ev; (void)data; }
void caml_runtime_events_init(void) { }
int caml_runtime_events_enabled(void) { return 0; }
void caml_runtime_events_destroy(void) { }

/* Unix I/O stubs */
#include <stdint.h>
typedef intptr_t value;

int caml_read_fd(int fd, int flags, void *buf, int n) {
    (void)flags; (void)buf;
    if (fd == 0) return 0;  /* stdin: EOF */
    return -1;
}

int caml_write_fd(int fd, int flags, void *buf, int n) {
    (void)flags;
    if (fd == 1 || fd == 2) {  /* stdout or stderr */
        const char *p = (const char *)buf;
        for (int i = 0; i < n; i++) {
            putchar(p[i]);
        }
        return n;  /* Success: wrote n bytes */
    }
    return -1;
}

int caml_num_rows_fd(int fd) {
    (void)fd;
    return 24;
}

/* Global data symbols */
value caml_global_data = 0;

/* Bytecode stubs - not used for native code but referenced */
int caml_byte_program_mode = 0;
void *caml_read_section_descriptors(void *fd, void *len) { (void)fd; (void)len; return NULL; }
void *caml_seek_optional_section(void *fd, void *sd, const char *name) { (void)fd; (void)sd; (void)name; return NULL; }
void *caml_attempt_open(void *name, void *trail, int mode) { (void)name; (void)trail; (void)mode; return NULL; }

/* System stubs from unix.c */
char *caml_secure_getenv(const char *name) {
    (void)name;
    return NULL;  /* No environment on bare metal */
}

/* Startup aux - smaller heap sizes for Pico */
#include <stdatomic.h>

#define PICO_MINOR_HEAP_WSZ  2048   /* 8KB minor heap per domain */
#define PICO_MAX_STACK_WSZ   2048   /* 8KB max stack per domain */

/* Field order MUST match caml/startup_aux.h exactly! */
struct caml_params {
    const char* proc_self_exe;
    const char* exe_name;
    const char* section_table;
    size_t section_table_size;
    const char* cds_file;
    uintptr_t parser_trace;
    uintptr_t trace_level;
    uintptr_t runtime_events_log_wsize;
    uintptr_t verify_heap;
    uintptr_t print_magic;
    uintptr_t print_config;
    uintptr_t init_percent_free;
    uintptr_t init_minor_heap_wsz;
    uintptr_t init_custom_major_ratio;
    uintptr_t init_custom_minor_ratio;
    uintptr_t init_custom_minor_max_bsz;
    uintptr_t init_max_stack_wsz;
    uintptr_t backtrace_enabled;
    uintptr_t runtime_warnings;
    uintptr_t cleanup_on_exit;
    uintptr_t event_trace;    /* <- This comes BEFORE max_domains! */
    uintptr_t max_domains;    /* <- This is the LAST field! */
};

static struct caml_params pico_params;
const struct caml_params* const caml_params = &pico_params;

void caml_parse_ocamlrunparam(void) {
    pico_params.init_percent_free = 80;  /* Reduced from 120 */
    pico_params.init_minor_heap_wsz = PICO_MINOR_HEAP_WSZ;
    pico_params.init_custom_major_ratio = 44;
    pico_params.init_custom_minor_ratio = 100;
    pico_params.init_custom_minor_max_bsz = 4096;  /* Reduced from 8192 */
    pico_params.init_max_stack_wsz = PICO_MAX_STACK_WSZ;
    pico_params.max_domains = 2;  /* Enable dual-core domains */
    pico_params.runtime_events_log_wsize = 0;
    pico_params.trace_level = 0;
    pico_params.cleanup_on_exit = 0;
    pico_params.print_magic = 0;
    pico_params.print_config = 0;
    pico_params.event_trace = 0;
}

static int startup_count = 0;
int caml_startup_aux(int pooling) {
    (void)pooling;
    startup_count++;
    return (startup_count == 1) ? 1 : 0;
}

void caml_shutdown(void) { startup_count = 0; }

void caml_init_exe_name(const char* proc_self_exe, const char* exe_name) {
    pico_params.proc_self_exe = proc_self_exe;
    pico_params.exe_name = exe_name;
}

void caml_init_section_table(const char* section_table, size_t section_table_size) {
    pico_params.section_table = section_table;
    pico_params.section_table_size = section_table_size;
}

void *caml_read_directory(const char *path, void *entries) { (void)path; (void)entries; return NULL; }

/* OO method dispatch - stub for caml_send0 (method with 0 arguments)
 * Real implementation would look up method in object vtable and call it.
 * This stub just returns unit - OO code won't work but allows linking. */
value caml_send0(value obj, value met) {
    (void)obj; (void)met;
    return 1;  /* Val_unit = 1 */
}

/* Platform pagesize - MUST be initialized before GC init! */
/* These are defined in platform.c but need to be set from unix.c which we skip */
extern intptr_t caml_plat_pagesize;
extern intptr_t caml_plat_mmap_alignment;

/* OS params and executable name stubs */
void caml_init_os_params(void) {
    caml_plat_pagesize = 4096;
    caml_plat_mmap_alignment = 4096;
}
char *caml_executable_name(void) { return "ocaml_pico"; }
char *caml_search_exe_in_path(const char *name) { (void)name; return "ocaml_pico"; }

/* Debug: override caml_fatal_error to see the message */
#include <stdarg.h>
void caml_fatal_error(const char *fmt, ...) {
    va_list ap;
    printf("FATAL ERROR: ");
    fflush(stdout);
    va_start(ap, fmt);
    vprintf(fmt, ap);
    va_end(ap);
    printf("\n");
    fflush(stdout);
    while(1) { sleep_ms(1000); }
}

/* Other functions from misc.c that we need */
void caml_gc_log(const char *fmt, ...) { (void)fmt; }

void caml_gc_message(int level, const char *fmt, ...) {
    (void)level; (void)fmt;
}

void caml_bad_caml_state(void) {
    printf("FATAL: bad caml state\n");
    printf("  __aeabi_read_tp() = %p\n", __aeabi_read_tp());
    fflush(stdout);
    while(1) { sleep_ms(1000); }
}

/* Verb gc flag and runtime warnings */
_Atomic uintnat caml_verb_gc = 0;
uintnat caml_runtime_warnings = 0;
int caml_runtime_warnings_active(void) { return 0; }

/* GC hooks - not used on Pico */
void (*caml_major_slice_begin_hook)(void) = NULL;
void (*caml_major_slice_end_hook)(void) = NULL;
void (*caml_minor_gc_begin_hook)(void) = NULL;
void (*caml_minor_gc_end_hook)(void) = NULL;

/* Extension table stubs */
void caml_ext_table_init(void *tbl, int init_cap) { (void)tbl; (void)init_cap; }
void caml_ext_table_add(void *tbl, void *data) { (void)tbl; (void)data; }
void caml_ext_table_free(void *tbl, int free_entries) { (void)tbl; (void)free_entries; }

/* Finaliser hooks - not used on Pico */
void (*caml_finalise_begin_hook)(void) = NULL;
void (*caml_finalise_end_hook)(void) = NULL;

/* Platform memory stubs */
void *caml_plat_mem_map(size_t size, int reserve_only) {
    (void)reserve_only;
    void *p = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
    return (p == MAP_FAILED) ? 0 : p;
}
void *caml_plat_mem_commit(void *addr, size_t size) {
    (void)size;
    return addr;
}
void caml_plat_mem_decommit(void *addr, size_t size) { (void)addr; (void)size; }
void caml_plat_mem_unmap(void *addr, size_t size) { munmap(addr, size); }

/* Platform mutex stubs - moved from platform.c to unix.c in rebase */
void caml_plat_mutex_init(caml_plat_mutex *m) {
    pthread_mutex_init(m, NULL);
}

void caml_plat_mutex_free(caml_plat_mutex *m) {
    pthread_mutex_destroy(m);
}

void caml_plat_lock_non_blocking_actual(caml_plat_mutex *m) {
    pthread_mutex_lock(m);
}

/* Platform condition variable stubs - moved from platform.c to unix.c in rebase */
void caml_plat_cond_init(caml_plat_cond *cond) {
    pthread_cond_init(cond, NULL);
}

void caml_plat_cond_free(caml_plat_cond *cond) {
    pthread_cond_destroy(cond);
}

void caml_plat_wait(caml_plat_cond *cond, caml_plat_mutex *mut) {
    pthread_cond_wait(cond, mut);
}

void caml_plat_broadcast(caml_plat_cond *cond) {
    pthread_cond_broadcast(cond);
}

void caml_plat_signal(caml_plat_cond *cond) {
    pthread_cond_signal(cond);
}

/* Stdlib location - bare metal has no filesystem */
char *caml_locate_standard_library(const char *exe_name,
                                   const char *stdlib_default,
                                   char **dirname) {
    (void)exe_name;
    (void)dirname;
    return (char *)stdlib_default;
}

/* Filesystem stubs - newlib doesn't provide these */
#include <sys/stat.h>
int chdir(const char *path) { (void)path; errno = ENOSYS; return -1; }
char *getcwd(char *buf, size_t size) { (void)buf; (void)size; errno = ENOSYS; return NULL; }
int mkdir(const char *path, mode_t mode) { (void)path; (void)mode; errno = ENOSYS; return -1; }
int rmdir(const char *path) { (void)path; errno = ENOSYS; return -1; }
