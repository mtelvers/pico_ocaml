/* net_stubs.h - Network types for OCaml lwIP integration on Pico 2 W */

#ifndef NET_STUBS_H
#define NET_STUBS_H

#include <stdint.h>
#include <stddef.h>

/* Event types for the network event queue */
typedef enum {
    NET_EVENT_NONE = 0,
    NET_EVENT_WIFI_CONNECTED,
    NET_EVENT_WIFI_DISCONNECTED,
    NET_EVENT_TCP_CONNECTED,
    NET_EVENT_TCP_RECEIVED,
    NET_EVENT_TCP_SENT,
    NET_EVENT_TCP_CLOSED,
    NET_EVENT_TCP_ERROR,
    NET_EVENT_UDP_RECEIVED,
    NET_EVENT_DNS_RESOLVED
} net_event_type_t;

/* Network event structure */
typedef struct {
    net_event_type_t type;
    int socket_id;
    union {
        struct {
            uint8_t *data;
            size_t len;
            uint32_t remote_ip;
            uint16_t remote_port;
        } received;
        struct {
            size_t len;
        } sent;
        struct {
            int error_code;
        } error;
        struct {
            uint32_t ip_addr;
        } dns;
    } u;
} net_event_t;

/* Socket states */
typedef enum {
    SOCKET_STATE_CLOSED = 0,
    SOCKET_STATE_CONNECTING,
    SOCKET_STATE_CONNECTED,
    SOCKET_STATE_LISTENING,
    SOCKET_STATE_ERROR
} socket_state_t;

/* Socket protocol types */
typedef enum {
    SOCKET_PROTO_TCP = 0,
    SOCKET_PROTO_UDP
} socket_proto_t;

/* Event queue size - power of 2 for efficient modulo */
#define NET_EVENT_QUEUE_SIZE 32
#define NET_EVENT_QUEUE_MASK (NET_EVENT_QUEUE_SIZE - 1)

/* Maximum sockets */
#define MAX_SOCKETS 8

/* Maximum receive buffer per socket */
#define MAX_RECV_BUFFER 4096

/* Initialize networking subsystem */
void net_init(void);

/* Poll for network events - call regularly */
void net_poll(void);

/* Get next event from queue (returns 0 if empty) */
int net_event_get(net_event_t *event);

/* WiFi functions */
int wifi_connect(const char *ssid, const char *password, uint32_t timeout_ms);
void wifi_disconnect(void);
int wifi_is_connected(void);
uint32_t wifi_get_ip(void);

/* TCP functions (pico_ prefix to avoid lwIP name conflicts) */
int pico_tcp_create(void);
int pico_tcp_connect(int sock_id, uint32_t ip, uint16_t port);
int pico_tcp_write(int sock_id, const uint8_t *data, size_t len);
int pico_tcp_read(int sock_id, uint8_t *buf, size_t max_len);
void pico_tcp_close(int sock_id);

/* UDP functions (pico_ prefix to avoid lwIP name conflicts) */
int pico_udp_create(void);
int pico_udp_bind(int sock_id, uint16_t port);
int pico_udp_sendto(int sock_id, uint32_t ip, uint16_t port, const uint8_t *data, size_t len);
int pico_udp_recvfrom(int sock_id, uint8_t *buf, size_t max_len, uint32_t *src_ip, uint16_t *src_port);
void pico_udp_close(int sock_id);

/* DNS resolution */
int dns_resolve(const char *hostname, uint32_t *ip_out);

/* Utility: IP address conversion */
uint32_t ip_from_string(const char *ip_str);
void ip_to_string(uint32_t ip, char *buf, size_t buf_len);

#endif /* NET_STUBS_H */
