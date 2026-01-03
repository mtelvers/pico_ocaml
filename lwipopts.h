/* lwipopts.h - lwIP configuration for OCaml on Pico 2 W */

#ifndef _LWIPOPTS_H
#define _LWIPOPTS_H

/* Platform settings */
#define NO_SYS                  1       /* No OS - bare metal */
#define LWIP_SOCKET             0       /* No socket API */
#define LWIP_NETCONN            0       /* No netconn API */

/* Memory options */
#define MEM_LIBC_MALLOC         0       /* Use lwIP's own malloc */
#define MEM_ALIGNMENT           4
#define MEM_SIZE                (8 * 1024)

/* PBUF options */
#define PBUF_POOL_SIZE          16

/* ARP options */
#define LWIP_ARP                1
#define ARP_TABLE_SIZE          10
#define ARP_QUEUEING            1

/* IP options */
#define IP_FORWARD              0
#define IP_REASSEMBLY           1
#define IP_FRAG                 1
#define IP_OPTIONS_ALLOWED      1
#define IP_REASS_MAX_PBUFS      10
#define MEMP_NUM_REASSDATA      5

/* ICMP options */
#define LWIP_ICMP               1

/* DHCP options */
#define LWIP_DHCP               1
#define DHCP_DOES_ARP_CHECK     0

/* DNS options */
#define LWIP_DNS                1
#define DNS_TABLE_SIZE          4
#define DNS_MAX_NAME_LENGTH     128
#define DNS_MAX_SERVERS         2

/* UDP options */
#define LWIP_UDP                1
#define UDP_TTL                 255
#define MEMP_NUM_UDP_PCB        4

/* TCP options */
#define LWIP_TCP                1
#define TCP_TTL                 255
#define TCP_MSS                 1460
#define TCP_WND                 (4 * TCP_MSS)
#define TCP_SND_BUF             (4 * TCP_MSS)
#define TCP_SND_QUEUELEN        ((4 * TCP_SND_BUF) / TCP_MSS)
#define TCP_QUEUE_OOSEQ         1
#define MEMP_NUM_TCP_PCB        4
#define MEMP_NUM_TCP_PCB_LISTEN 2
#define MEMP_NUM_TCP_SEG        16

/* Network interface options */
#define LWIP_NETIF_HOSTNAME     1
#define LWIP_NETIF_STATUS_CALLBACK 1
#define LWIP_NETIF_LINK_CALLBACK 1

/* Stats */
#define LWIP_STATS              0
#define LWIP_STATS_DISPLAY      0

/* Checksum */
#define LWIP_CHECKSUM_CTRL_PER_NETIF 1
#define CHECKSUM_GEN_IP         1
#define CHECKSUM_GEN_UDP        1
#define CHECKSUM_GEN_TCP        1
#define CHECKSUM_CHECK_IP       1
#define CHECKSUM_CHECK_UDP      1
#define CHECKSUM_CHECK_TCP      1

/* Sequential API */
#define LWIP_TCPIP_CORE_LOCKING 0

/* Hook for thread safety (CYW43 arch layer handles this) */
#define LWIP_TCPIP_CORE_LOCKING_INPUT 0

/* Debug (disable for production) */
#define LWIP_DEBUG              0

/* Prevent duplication of errno */
#define LWIP_PROVIDE_ERRNO      0

#endif /* _LWIPOPTS_H */
