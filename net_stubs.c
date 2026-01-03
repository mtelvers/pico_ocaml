/* net_stubs.c - Network stubs for OCaml lwIP integration on Pico 2 W
 *
 * Provides WiFi connectivity and TCP/UDP networking using lwIP in polling mode.
 * Designed to integrate with OCaml effects for direct-style async I/O.
 */

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "pico/stdlib.h"
#include "pico/cyw43_arch.h"
#include "hardware/sync.h"

#include "lwip/tcp.h"
#include "lwip/udp.h"
#include "lwip/dns.h"
#include "lwip/pbuf.h"
#include "lwip/ip_addr.h"

#include "net_stubs.h"

/* OCaml value types */
typedef intptr_t value;
#define Val_unit ((value) 1)
#define Val_int(x) (((value)(x) << 1) + 1)
#define Int_val(x) ((x) >> 1)
#define Val_bool(x) ((x) ? 3 : 1)
#define Bool_val(x) ((x) != 1)
#define String_val(x) ((char *)(x))
#define Bytes_val(x) ((unsigned char *)(x))

/* caml_alloc_string from OCaml runtime */
extern value caml_alloc_string(size_t len);
extern size_t caml_string_length(value s);

/* ============================================================================
 * Event Queue - Thread-safe SPSC ring buffer
 * ============================================================================ */

static net_event_t event_queue[NET_EVENT_QUEUE_SIZE];
static volatile uint32_t event_queue_head = 0;  /* Written by producer (lwIP callbacks) */
static volatile uint32_t event_queue_tail = 0;  /* Read by consumer (OCaml) */

/* Spinlock for multicore access */
static volatile uint32_t net_lock = 0;

static void net_lock_acquire(void) {
    while (__atomic_test_and_set(&net_lock, __ATOMIC_ACQUIRE)) {
        __wfe();
    }
}

static void net_lock_release(void) {
    __atomic_clear(&net_lock, __ATOMIC_RELEASE);
    __sev();
}

/* Enqueue an event (called from lwIP callbacks) */
static int event_enqueue(const net_event_t *event) {
    uint32_t head = event_queue_head;
    uint32_t next_head = (head + 1) & NET_EVENT_QUEUE_MASK;

    /* Check if queue is full */
    if (next_head == event_queue_tail) {
        return -1;  /* Queue full, drop event */
    }

    event_queue[head] = *event;
    __dmb();  /* Ensure event is written before updating head */
    event_queue_head = next_head;

    return 0;
}

/* Dequeue an event (called from OCaml) */
int net_event_get(net_event_t *event) {
    uint32_t tail = event_queue_tail;

    /* Check if queue is empty */
    if (tail == event_queue_head) {
        return 0;  /* No event */
    }

    *event = event_queue[tail];
    __dmb();  /* Ensure event is read before updating tail */
    event_queue_tail = (tail + 1) & NET_EVENT_QUEUE_MASK;

    return 1;
}

/* ============================================================================
 * Socket State Management
 * ============================================================================ */

typedef struct {
    socket_proto_t proto;
    socket_state_t state;
    union {
        struct tcp_pcb *tcp;
        struct udp_pcb *udp;
    } pcb;
    /* Receive buffer */
    uint8_t *recv_buf;
    size_t recv_len;
    size_t recv_capacity;
    /* For UDP: source address of last received packet */
    uint32_t udp_src_ip;
    uint16_t udp_src_port;
} socket_t;

static socket_t sockets[MAX_SOCKETS];
static int net_initialized = 0;

/* Allocate a socket slot */
static int socket_alloc(socket_proto_t proto) {
    for (int i = 0; i < MAX_SOCKETS; i++) {
        if (sockets[i].state == SOCKET_STATE_CLOSED) {
            memset(&sockets[i], 0, sizeof(socket_t));
            sockets[i].proto = proto;
            sockets[i].state = SOCKET_STATE_CLOSED;
            sockets[i].recv_capacity = MAX_RECV_BUFFER;
            sockets[i].recv_buf = malloc(MAX_RECV_BUFFER);
            if (!sockets[i].recv_buf) {
                return -1;
            }
            return i;
        }
    }
    return -1;  /* No free slots */
}

/* Free a socket slot */
static void socket_free(int sock_id) {
    if (sock_id < 0 || sock_id >= MAX_SOCKETS) return;

    socket_t *sock = &sockets[sock_id];
    if (sock->recv_buf) {
        free(sock->recv_buf);
        sock->recv_buf = NULL;
    }
    sock->state = SOCKET_STATE_CLOSED;
    sock->pcb.tcp = NULL;
}

/* ============================================================================
 * WiFi Functions
 * ============================================================================ */

void net_init(void) {
    if (net_initialized) return;

    /* Initialize all socket slots */
    memset(sockets, 0, sizeof(sockets));

    /* cyw43_arch_init() should already be called from pico_main.c */
    net_initialized = 1;
}

int wifi_connect(const char *ssid, const char *password, uint32_t timeout_ms) {
    net_init();

    /* Enable station mode */
    cyw43_arch_enable_sta_mode();

    /* Connect to WiFi (blocking with timeout) */
    int result = cyw43_arch_wifi_connect_timeout_ms(ssid, password,
        CYW43_AUTH_WPA2_AES_PSK, timeout_ms);

    if (result == 0) {
        /* Enqueue connected event */
        net_event_t evt = { .type = NET_EVENT_WIFI_CONNECTED };
        event_enqueue(&evt);
    }

    return result;
}

void wifi_disconnect(void) {
    cyw43_arch_disable_sta_mode();

    /* Enqueue disconnected event */
    net_event_t evt = { .type = NET_EVENT_WIFI_DISCONNECTED };
    event_enqueue(&evt);
}

int wifi_is_connected(void) {
    return cyw43_wifi_link_status(&cyw43_state, CYW43_ITF_STA) == CYW43_LINK_JOIN;
}

uint32_t wifi_get_ip(void) {
    if (!wifi_is_connected()) return 0;
    return cyw43_state.netif[CYW43_ITF_STA].ip_addr.addr;
}

/* Poll network - must be called regularly */
void net_poll(void) {
    cyw43_arch_poll();
}

/* ============================================================================
 * TCP Callbacks
 * ============================================================================ */

static err_t tcp_recv_callback(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err) {
    int sock_id = (int)(intptr_t)arg;

    if (sock_id < 0 || sock_id >= MAX_SOCKETS) {
        if (p) pbuf_free(p);
        return ERR_VAL;
    }

    socket_t *sock = &sockets[sock_id];

    if (p == NULL) {
        /* Connection closed by remote */
        sock->state = SOCKET_STATE_CLOSED;
        net_event_t evt = {
            .type = NET_EVENT_TCP_CLOSED,
            .socket_id = sock_id
        };
        event_enqueue(&evt);
        return ERR_OK;
    }

    if (err != ERR_OK) {
        pbuf_free(p);
        return err;
    }

    /* Copy data to receive buffer */
    net_lock_acquire();
    size_t space = sock->recv_capacity - sock->recv_len;
    size_t to_copy = (p->tot_len < space) ? p->tot_len : space;
    if (to_copy > 0) {
        pbuf_copy_partial(p, sock->recv_buf + sock->recv_len, to_copy, 0);
        sock->recv_len += to_copy;
    }
    net_lock_release();

    /* Acknowledge received data */
    tcp_recved(tpcb, p->tot_len);
    pbuf_free(p);

    /* Enqueue received event */
    net_event_t evt = {
        .type = NET_EVENT_TCP_RECEIVED,
        .socket_id = sock_id,
        .u.received.len = to_copy
    };
    event_enqueue(&evt);

    return ERR_OK;
}

static err_t tcp_sent_callback(void *arg, struct tcp_pcb *tpcb, u16_t len) {
    int sock_id = (int)(intptr_t)arg;

    /* Enqueue sent event */
    net_event_t evt = {
        .type = NET_EVENT_TCP_SENT,
        .socket_id = sock_id,
        .u.sent.len = len
    };
    event_enqueue(&evt);

    return ERR_OK;
}

static void tcp_err_callback(void *arg, err_t err) {
    int sock_id = (int)(intptr_t)arg;

    if (sock_id >= 0 && sock_id < MAX_SOCKETS) {
        sockets[sock_id].state = SOCKET_STATE_ERROR;
        sockets[sock_id].pcb.tcp = NULL;  /* PCB already freed by lwIP */
    }

    /* Enqueue error event */
    net_event_t evt = {
        .type = NET_EVENT_TCP_ERROR,
        .socket_id = sock_id,
        .u.error.error_code = err
    };
    event_enqueue(&evt);
}

static err_t tcp_connected_callback(void *arg, struct tcp_pcb *tpcb, err_t err) {
    int sock_id = (int)(intptr_t)arg;

    if (sock_id >= 0 && sock_id < MAX_SOCKETS) {
        if (err == ERR_OK) {
            sockets[sock_id].state = SOCKET_STATE_CONNECTED;
        } else {
            sockets[sock_id].state = SOCKET_STATE_ERROR;
        }
    }

    /* Enqueue connected event */
    net_event_t evt = {
        .type = NET_EVENT_TCP_CONNECTED,
        .socket_id = sock_id,
        .u.error.error_code = err
    };
    event_enqueue(&evt);

    return ERR_OK;
}

/* ============================================================================
 * TCP Functions
 * ============================================================================ */

int pico_tcp_create(void) {
    int sock_id = socket_alloc(SOCKET_PROTO_TCP);
    if (sock_id < 0) return -1;

    struct tcp_pcb *pcb = tcp_new();
    if (!pcb) {
        socket_free(sock_id);
        return -1;
    }

    sockets[sock_id].pcb.tcp = pcb;

    /* Set callbacks */
    tcp_arg(pcb, (void *)(intptr_t)sock_id);
    tcp_recv(pcb, tcp_recv_callback);
    tcp_sent(pcb, tcp_sent_callback);
    tcp_err(pcb, tcp_err_callback);

    return sock_id;
}

int pico_tcp_connect(int sock_id, uint32_t ip, uint16_t port) {
    if (sock_id < 0 || sock_id >= MAX_SOCKETS) return -1;

    socket_t *sock = &sockets[sock_id];
    if (sock->proto != SOCKET_PROTO_TCP || !sock->pcb.tcp) return -1;

    ip_addr_t addr;
    ip_addr_set_ip4_u32(&addr, ip);

    sock->state = SOCKET_STATE_CONNECTING;

    cyw43_arch_lwip_begin();
    err_t err = tcp_connect(sock->pcb.tcp, &addr, port, tcp_connected_callback);
    cyw43_arch_lwip_end();

    return (err == ERR_OK) ? 0 : -1;
}

int pico_tcp_write(int sock_id, const uint8_t *data, size_t len) {
    if (sock_id < 0 || sock_id >= MAX_SOCKETS) return -1;

    socket_t *sock = &sockets[sock_id];
    if (sock->proto != SOCKET_PROTO_TCP || !sock->pcb.tcp) return -1;
    if (sock->state != SOCKET_STATE_CONNECTED) return -1;

    cyw43_arch_lwip_begin();
    err_t err = tcp_write(sock->pcb.tcp, data, len, TCP_WRITE_FLAG_COPY);
    if (err == ERR_OK) {
        tcp_output(sock->pcb.tcp);
    }
    cyw43_arch_lwip_end();

    return (err == ERR_OK) ? (int)len : -1;
}

int pico_tcp_read(int sock_id, uint8_t *buf, size_t max_len) {
    if (sock_id < 0 || sock_id >= MAX_SOCKETS) return -1;

    socket_t *sock = &sockets[sock_id];
    if (sock->proto != SOCKET_PROTO_TCP) return -1;

    net_lock_acquire();
    size_t to_read = (sock->recv_len < max_len) ? sock->recv_len : max_len;
    if (to_read > 0) {
        memcpy(buf, sock->recv_buf, to_read);
        /* Shift remaining data */
        if (to_read < sock->recv_len) {
            memmove(sock->recv_buf, sock->recv_buf + to_read, sock->recv_len - to_read);
        }
        sock->recv_len -= to_read;
    }
    socket_state_t state = sock->state;
    net_lock_release();

    /* Return -2 if connection closed and no more data */
    if (to_read == 0 && state == SOCKET_STATE_CLOSED) {
        return -2;
    }

    return (int)to_read;
}

void pico_tcp_close(int sock_id) {
    if (sock_id < 0 || sock_id >= MAX_SOCKETS) return;

    socket_t *sock = &sockets[sock_id];
    if (sock->proto != SOCKET_PROTO_TCP) return;

    if (sock->pcb.tcp) {
        cyw43_arch_lwip_begin();
        tcp_arg(sock->pcb.tcp, NULL);
        tcp_recv(sock->pcb.tcp, NULL);
        tcp_sent(sock->pcb.tcp, NULL);
        tcp_err(sock->pcb.tcp, NULL);
        tcp_close(sock->pcb.tcp);  /* lwIP function */
        cyw43_arch_lwip_end();
    }

    socket_free(sock_id);
}

/* ============================================================================
 * UDP Callbacks
 * ============================================================================ */

static void udp_recv_callback(void *arg, struct udp_pcb *pcb, struct pbuf *p,
                               const ip_addr_t *addr, u16_t port) {
    int sock_id = (int)(intptr_t)arg;

    if (sock_id < 0 || sock_id >= MAX_SOCKETS || !p) {
        if (p) pbuf_free(p);
        return;
    }

    socket_t *sock = &sockets[sock_id];

    /* Copy data to receive buffer */
    net_lock_acquire();
    size_t space = sock->recv_capacity - sock->recv_len;
    size_t to_copy = (p->tot_len < space) ? p->tot_len : space;
    if (to_copy > 0) {
        pbuf_copy_partial(p, sock->recv_buf + sock->recv_len, to_copy, 0);
        sock->recv_len += to_copy;
        sock->udp_src_ip = ip_addr_get_ip4_u32(addr);
        sock->udp_src_port = port;
    }
    net_lock_release();

    pbuf_free(p);

    /* Enqueue received event */
    net_event_t evt = {
        .type = NET_EVENT_UDP_RECEIVED,
        .socket_id = sock_id,
        .u.received.len = to_copy,
        .u.received.remote_ip = ip_addr_get_ip4_u32(addr),
        .u.received.remote_port = port
    };
    event_enqueue(&evt);
}

/* ============================================================================
 * UDP Functions
 * ============================================================================ */

int pico_udp_create(void) {
    int sock_id = socket_alloc(SOCKET_PROTO_UDP);
    if (sock_id < 0) return -1;

    struct udp_pcb *pcb = udp_new();
    if (!pcb) {
        socket_free(sock_id);
        return -1;
    }

    sockets[sock_id].pcb.udp = pcb;
    sockets[sock_id].state = SOCKET_STATE_CONNECTED;  /* UDP is connectionless */

    /* Set callback */
    udp_recv(pcb, udp_recv_callback, (void *)(intptr_t)sock_id);

    return sock_id;
}

int pico_udp_bind(int sock_id, uint16_t port) {
    if (sock_id < 0 || sock_id >= MAX_SOCKETS) return -1;

    socket_t *sock = &sockets[sock_id];
    if (sock->proto != SOCKET_PROTO_UDP || !sock->pcb.udp) return -1;

    cyw43_arch_lwip_begin();
    err_t err = udp_bind(sock->pcb.udp, IP_ADDR_ANY, port);  /* lwIP function */
    cyw43_arch_lwip_end();

    return (err == ERR_OK) ? 0 : -1;
}

int pico_udp_sendto(int sock_id, uint32_t ip, uint16_t port, const uint8_t *data, size_t len) {
    if (sock_id < 0 || sock_id >= MAX_SOCKETS) return -1;

    socket_t *sock = &sockets[sock_id];
    if (sock->proto != SOCKET_PROTO_UDP || !sock->pcb.udp) return -1;

    struct pbuf *p = pbuf_alloc(PBUF_TRANSPORT, len, PBUF_RAM);
    if (!p) return -1;

    memcpy(p->payload, data, len);

    ip_addr_t addr;
    ip_addr_set_ip4_u32(&addr, ip);

    cyw43_arch_lwip_begin();
    err_t err = udp_sendto(sock->pcb.udp, p, &addr, port);  /* lwIP function */
    cyw43_arch_lwip_end();

    pbuf_free(p);

    return (err == ERR_OK) ? (int)len : -1;
}

int pico_udp_recvfrom(int sock_id, uint8_t *buf, size_t max_len, uint32_t *src_ip, uint16_t *src_port) {
    if (sock_id < 0 || sock_id >= MAX_SOCKETS) return -1;

    socket_t *sock = &sockets[sock_id];
    if (sock->proto != SOCKET_PROTO_UDP) return -1;

    net_lock_acquire();
    size_t to_read = (sock->recv_len < max_len) ? sock->recv_len : max_len;
    if (to_read > 0) {
        memcpy(buf, sock->recv_buf, to_read);
        if (src_ip) *src_ip = sock->udp_src_ip;
        if (src_port) *src_port = sock->udp_src_port;
        /* Clear buffer after read (UDP is datagram-based) */
        sock->recv_len = 0;
    }
    net_lock_release();

    return (int)to_read;
}

void pico_udp_close(int sock_id) {
    if (sock_id < 0 || sock_id >= MAX_SOCKETS) return;

    socket_t *sock = &sockets[sock_id];
    if (sock->proto != SOCKET_PROTO_UDP) return;

    if (sock->pcb.udp) {
        cyw43_arch_lwip_begin();
        udp_remove(sock->pcb.udp);
        cyw43_arch_lwip_end();
    }

    socket_free(sock_id);
}

/* ============================================================================
 * DNS Resolution
 * ============================================================================ */

static volatile int dns_done = 0;
static volatile uint32_t dns_result_ip = 0;

static void dns_callback(const char *name, const ip_addr_t *ipaddr, void *arg) {
    (void)name;
    (void)arg;

    if (ipaddr) {
        dns_result_ip = ip_addr_get_ip4_u32(ipaddr);
    } else {
        dns_result_ip = 0;
    }
    dns_done = 1;
}

int dns_resolve(const char *hostname, uint32_t *ip_out) {
    ip_addr_t addr;

    cyw43_arch_lwip_begin();
    err_t err = dns_gethostbyname(hostname, &addr, dns_callback, NULL);
    cyw43_arch_lwip_end();

    if (err == ERR_OK) {
        /* Result was cached */
        *ip_out = ip_addr_get_ip4_u32(&addr);
        return 0;
    }

    if (err == ERR_INPROGRESS) {
        /* Wait for callback */
        dns_done = 0;
        while (!dns_done) {
            cyw43_arch_poll();
            sleep_ms(10);
        }
        if (dns_result_ip != 0) {
            *ip_out = dns_result_ip;
            return 0;
        }
    }

    return -1;
}

/* ============================================================================
 * Utility Functions
 * ============================================================================ */

uint32_t ip_from_string(const char *ip_str) {
    ip_addr_t addr;
    if (ip4addr_aton(ip_str, ip_2_ip4(&addr))) {
        return ip_addr_get_ip4_u32(&addr);
    }
    return 0;
}

void ip_to_string(uint32_t ip, char *buf, size_t buf_len) {
    ip_addr_t addr;
    ip_addr_set_ip4_u32(&addr, ip);
    snprintf(buf, buf_len, "%s", ip4addr_ntoa(ip_2_ip4(&addr)));
}

/* ============================================================================
 * OCaml Stubs
 * ============================================================================ */

/* WiFi stubs */
value ocaml_wifi_connect(value ssid, value password, value timeout) {
    int result = wifi_connect(String_val(ssid), String_val(password), Int_val(timeout));
    return Val_int(result);
}

value ocaml_wifi_disconnect(value unit) {
    (void)unit;
    wifi_disconnect();
    return Val_unit;
}

value ocaml_wifi_is_connected(value unit) {
    (void)unit;
    return Val_bool(wifi_is_connected());
}

value ocaml_wifi_get_ip(value unit) {
    (void)unit;
    return Val_int(wifi_get_ip());
}

/* Network polling */
value ocaml_net_poll(value unit) {
    (void)unit;
    net_poll();
    return Val_unit;
}

/* TCP stubs */
value ocaml_tcp_create(value unit) {
    (void)unit;
    return Val_int(pico_tcp_create());
}

/* tcp_connect_raw : int -> int -> int -> int  (sock, ip_int, port) */
value ocaml_tcp_connect(value sock, value ip, value port) {
    return Val_int(pico_tcp_connect(Int_val(sock), Int_val(ip), Int_val(port)));
}

/* tcp_write_raw : int -> bytes -> int -> int  (sock, data, len) */
value ocaml_tcp_write(value sock, value data, value len) {
    return Val_int(pico_tcp_write(Int_val(sock), Bytes_val(data), Int_val(len)));
}

/* tcp_read_raw : int -> bytes -> int -> int  (sock, buf, max_len) -> bytes_read */
value ocaml_tcp_read(value sock, value buf, value max_len) {
    int got = pico_tcp_read(Int_val(sock), Bytes_val(buf), Int_val(max_len));
    return Val_int(got);
}

value ocaml_tcp_close(value sock) {
    pico_tcp_close(Int_val(sock));
    return Val_unit;
}

/* UDP stubs */
value ocaml_udp_create(value unit) {
    (void)unit;
    return Val_int(pico_udp_create());
}

value ocaml_udp_bind(value sock, value port) {
    return Val_int(pico_udp_bind(Int_val(sock), Int_val(port)));
}

/* udp_sendto_raw : int -> int -> int -> bytes -> int -> int
   (sock, ip_int, port, data, len) */
value ocaml_udp_sendto(value sock, value ip, value port, value data, value len) {
    return Val_int(pico_udp_sendto(Int_val(sock), Int_val(ip), Int_val(port),
                                   Bytes_val(data), Int_val(len)));
}

/* udp_recvfrom_raw : int -> bytes -> int  (sock, buf) -> bytes_read */
value ocaml_udp_recvfrom(value sock, value buf) {
    uint32_t src_ip;
    uint16_t src_port;
    /* Note: for simplicity, we don't return src_ip/src_port here.
       A more complete implementation would use a tuple. */
    int got = pico_udp_recvfrom(Int_val(sock), Bytes_val(buf),
                                 caml_string_length(buf), &src_ip, &src_port);
    return Val_int(got);
}

value ocaml_udp_close(value sock) {
    pico_udp_close(Int_val(sock));
    return Val_unit;
}

/* DNS stub - returns IP as integer, 0 on failure */
value ocaml_dns_resolve(value hostname) {
    uint32_t ip;
    if (dns_resolve(String_val(hostname), &ip) == 0) {
        return Val_int(ip);
    }
    return Val_int(0);  /* Failure */
}

/* Check for pending events */
value ocaml_net_has_event(value unit) {
    (void)unit;
    return Val_bool(event_queue_head != event_queue_tail);
}

/* ============================================================================
 * Additional stubs for net.ml
 * ============================================================================ */

/* lwip_service_raw : unit -> unit */
value ocaml_lwip_service(value unit) {
    (void)unit;
    cyw43_arch_poll();
    return Val_unit;
}

/* ip_from_string_raw : string -> int */
value ocaml_ip_from_string(value ip_str) {
    return Val_int(ip_from_string(String_val(ip_str)));
}

/* ip_to_string_raw : int -> string */
value ocaml_ip_to_string(value ip) {
    char buf[16];
    ip_to_string(Int_val(ip), buf, sizeof(buf));
    value s = caml_alloc_string(strlen(buf));
    memcpy(Bytes_val(s), buf, strlen(buf));
    return s;
}

/* Note: ocaml_sleep_ms and ocaml_time_ms are defined in pico_main.c */
