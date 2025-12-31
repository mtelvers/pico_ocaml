/* frametables.S - Frame table array for OCaml stack walking
 * Only include frametables for modules actually used by hello.ml
 * Adding more frametables here will pull in those modules! */
    .syntax unified
    .thumb
    .section .rodata
    .align 2

/* Frame tables for stack walking during GC */
    .global caml_frametable
    .type caml_frametable, %object
caml_frametable:
    .word caml_system.frametable
    .word camlHello.frametable
    .word camlStdlib__Domain.frametable
    .word camlStdlib__Mutex.frametable
    .word camlStdlib__Condition.frametable
    .word camlStdlib__Atomic.frametable
    .word camlStdlib__List.frametable
    .word camlStdlib__Seq.frametable
    .word 0
    .size caml_frametable, .-caml_frametable

/* Note: caml_globals is defined in ocaml_stubs.c
 * It must list all module data blocks for major GC root scanning */
