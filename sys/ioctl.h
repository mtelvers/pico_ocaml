/* Stub sys/ioctl.h for bare-metal */
#ifndef _SYS_IOCTL_H
#define _SYS_IOCTL_H

/* We don't support ioctl on bare metal */
#define TIOCGWINSZ 0

struct winsize {
    unsigned short ws_row;
    unsigned short ws_col;
    unsigned short ws_xpixel;
    unsigned short ws_ypixel;
};

static inline int ioctl(int fd, unsigned long request, ...) {
    (void)fd; (void)request;
    return -1;
}

#endif
