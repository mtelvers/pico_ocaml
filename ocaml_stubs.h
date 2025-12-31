/* Minimal POSIX stubs for OCaml runtime on bare-metal Pico */
/* This header just provides macros and type aliases - function implementations in ocaml_stubs.c */

#ifndef OCAML_STUBS_H
#define OCAML_STUBS_H

/* Signal jump buffer - just use regular jmp_buf */
#include <setjmp.h>
typedef jmp_buf sigjmp_buf;
#define sigsetjmp(env, savemask) setjmp(env)
#define siglongjmp(env, val) longjmp(env, val)

/* Signal flags - define to 0 if not present */
#ifndef SA_SIGINFO
#define SA_SIGINFO 0
#endif
#ifndef SA_ONSTACK
#define SA_ONSTACK 0
#endif
#ifndef SA_RESTART
#define SA_RESTART 0
#endif

/* Pthread mutex/cond initializers - use -1 as "uninitialized" sentinel
   to avoid multiple static inits sharing slot 0 */
#ifndef PTHREAD_MUTEX_INITIALIZER
#define PTHREAD_MUTEX_INITIALIZER (-1)
#endif
#ifndef PTHREAD_COND_INITIALIZER
#define PTHREAD_COND_INITIALIZER (-1)
#endif
#ifndef PTHREAD_MUTEX_ERRORCHECK
#define PTHREAD_MUTEX_ERRORCHECK 0
#endif

/* CPU affinity stubs */
typedef unsigned int cpu_set_t;
#define CPU_ZERO(set) (*(set) = 0)
#define CPU_COUNT(set) (1)

/* mmap constants */
#ifndef PROT_READ
#define PROT_READ 1
#define PROT_WRITE 2
#define PROT_NONE 0
#define MAP_PRIVATE 1
#define MAP_ANONYMOUS 2
#define MAP_ANON MAP_ANONYMOUS
#define MAP_FIXED 4
#define MAP_FAILED ((void*)-1)
#endif

/* nanosleep stub */
#include <time.h>
int nanosleep(const struct timespec *req, struct timespec *rem);

/* strtod_l stub - ignores locale */
#include <locale.h>
double strtod_l(const char *nptr, char **endptr, locale_t loc);

/* TLS initialization for multicore - call before OCaml startup */
void pico_set_tls_for_core(int core);

#endif /* OCAML_STUBS_H */
