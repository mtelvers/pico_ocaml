/* Stub sys/mman.h for bare-metal - actual impl in ocaml_stubs.h */
#ifndef _SYS_MMAN_H
#define _SYS_MMAN_H

#include <stddef.h>
#include <sys/types.h>

/* These are defined in ocaml_stubs.h */
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

void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);
int munmap(void *addr, size_t length);
int mprotect(void *addr, size_t len, int prot);

#endif
