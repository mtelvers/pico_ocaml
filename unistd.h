/* Local unistd.h wrapper - hides link() to avoid conflict with OCaml's link type */
#ifndef _PICO_UNISTD_H
#define _PICO_UNISTD_H

/* Include real unistd.h */
#include_next <unistd.h>

/* Undefine link if it was defined as a macro, and hide the function */
#undef link
#define link hidden_posix_link

#endif /* _PICO_UNISTD_H */
