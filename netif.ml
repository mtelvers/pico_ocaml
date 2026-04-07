(* netif.ml - Low-level network interface for Pico 2 W *)
(* Raw C stubs and helpers. No effects, no types, minimal allocation. *)

(* WiFi control *)
external wifi_connect : string -> string -> int -> int = "ocaml_wifi_connect"
external wifi_disconnect : unit -> unit = "ocaml_wifi_disconnect"
external wifi_is_connected : unit -> int = "ocaml_wifi_is_connected"
external wifi_get_ip : unit -> int = "ocaml_wifi_get_ip"

(* TCP sockets *)
external tcp_create : unit -> int = "ocaml_tcp_create"
external tcp_connect : int -> int -> int -> int = "ocaml_tcp_connect"
external tcp_write : int -> bytes -> int -> int = "ocaml_tcp_write"
external tcp_read : int -> bytes -> int -> int = "ocaml_tcp_read"
external tcp_close : int -> unit = "ocaml_tcp_close"

(* UDP sockets *)
external udp_create : unit -> int = "ocaml_udp_create"
external udp_bind : int -> int -> int = "ocaml_udp_bind"
external udp_sendto : int -> int -> int -> bytes -> int -> int = "ocaml_udp_sendto"
external udp_recvfrom : int -> bytes -> int = "ocaml_udp_recvfrom"
external udp_close : int -> unit = "ocaml_udp_close"

(* DNS resolution *)
external dns_resolve : string -> int = "ocaml_dns_resolve"

(* Network polling *)
external net_poll : unit -> unit = "ocaml_net_poll"
external lwip_service : unit -> unit = "ocaml_lwip_service"

let service_network () =
  lwip_service ();
  net_poll ()

(* IP utilities *)
external ip_from_string : string -> int = "ocaml_ip_from_string"

let ip_to_string ip =
  let b0 = ip land 0xff in
  let b1 = (ip lsr 8) land 0xff in
  let b2 = (ip lsr 16) land 0xff in
  let b3 = (ip lsr 24) land 0xff in
  string_of_int b0 ^ "." ^ string_of_int b1 ^ "." ^
  string_of_int b2 ^ "." ^ string_of_int b3
