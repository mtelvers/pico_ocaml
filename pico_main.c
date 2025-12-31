/* Main entry point for OCaml 5 on Pico 2 W
 *
 * Provides OCaml-callable functions for:
 * - Console output (print_string, print_int)
 * - GPIO and LED control
 * - Timing (time_ms)
 */

#include <stdio.h>
#include <stdatomic.h>
#include "pico/stdlib.h"
#include "pico/cyw43_arch.h"
#include "pico/multicore.h"
#include "hardware/sync.h"


/* TLS initialization */
extern void pico_set_tls_for_core(int core);

/* OCaml runtime headers */
#define CAML_INTERNALS
#include "caml/mlvalues.h"
#include "caml/callback.h"
#include "caml/memory.h"
#include "caml/alloc.h"

/* Raw output for OCaml - avoids printf contention */
extern void raw_lock(void);
extern void raw_unlock(void);

/* Per-core print buffers to avoid stack usage */
static char print_buf[2][128];

value pico_print_string(value s) {
    int core = (*(volatile unsigned int *)0xd0000000) & 1;
    const char *src = String_val(s);
    mlsize_t len = caml_string_length(s);
    char *buf = print_buf[core];
    if (len > 127) len = 127;
    for (mlsize_t i = 0; i < len; i++) buf[i] = src[i];
    buf[len] = '\0';

    raw_lock();
    char *p = buf;
    while (*p) putchar_raw(*p++);
    raw_unlock();
    return Val_unit;
}

value pico_print(value s) {
    pico_print_string(s);
    raw_lock();
    putchar_raw('\r');
    putchar_raw('\n');
    raw_unlock();
    return Val_unit;
}

value pico_print_int(value n) {
    int core = (*(volatile unsigned int *)0xd0000000) & 1;
    char buf[16];
    int val = (int)Long_val(n);
    int i = 0;
    if (val < 0) { buf[i++] = '-'; val = -val; }
    if (val == 0) buf[i++] = '0';
    else {
        char tmp[12];
        int j = 0;
        while (val > 0) { tmp[j++] = '0' + (val % 10); val /= 10; }
        while (j > 0) buf[i++] = tmp[--j];
    }
    buf[i] = '\0';

    raw_lock();
    char *p = buf;
    while (*p) putchar_raw(*p++);
    raw_unlock();
    return Val_unit;
}

value ocaml_cyw43_init(value unit) {
    (void)unit;
    int result = cyw43_arch_init();
    return result ? Val_true : Val_false;
}

value ocaml_cyw43_led_set(value on) {
    cyw43_arch_gpio_put(CYW43_WL_GPIO_LED_PIN, Bool_val(on));
    return Val_unit;
}

value ocaml_sleep_ms(value ms) {
    sleep_ms(Long_val(ms));
    return Val_unit;
}

value ocaml_time_ms(value unit) {
    (void)unit;
    return Val_long((long)(time_us_64() / 1000));
}

value ocaml_gpio_init(value pin) {
    gpio_init(Long_val(pin));
    return Val_unit;
}

value ocaml_gpio_set_dir_out(value pin) {
    gpio_set_dir(Long_val(pin), GPIO_OUT);
    return Val_unit;
}

value ocaml_gpio_put(value pin, value on) {
    gpio_put(Long_val(pin), Bool_val(on));
    return Val_unit;
}

/* Initialize malloc mutex for multicore safety */
extern void init_malloc_mutex(void);
extern void init_sbrk_mutex(void);

int main(void) {
    /* Initialize Pico stdio first */
    stdio_init_all();

    /* Initialize malloc mutex BEFORE any threads could use it */
    init_malloc_mutex();

    /* Initialize sbrk mutex for multicore heap safety */
    init_sbrk_mutex();

    /* Create our own argv for OCaml - bare metal has no real command line */
    static char *fake_argv[] = { "ocaml_pico", NULL };

    /* Wait for USB connection */
    for (int i = 0; i < 10; i++) {
        printf("Waiting for USB... %d\n", i);
        sleep_ms(500);
    }

    printf("\n================================\n");
    printf("OCaml 5 on Pico 2 W\n");
    printf("================================\n\n");

    /* Show heap info */
    extern char __end__;
    extern char __HeapLimit;
    printf("Heap: %uKB available\n", (unsigned)(&__HeapLimit - &__end__) / 1024);
    fflush(stdout);

    printf("Starting OCaml...\n");
    fflush(stdout);

    caml_startup(fake_argv);

    printf("OCaml returned!\n");

    /* Heartbeat loop */
    int count = 0;
    while (1) {
        printf("Heartbeat %d\n", count++);
        sleep_ms(2000);
    }

    return 0;
}
