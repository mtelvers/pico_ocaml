(* net.ml - OCaml 5 effects-based networking for Pico 2 W *)
(* Defines network effect types and API modules *)
(* Effect handling is done by Pio for integration with fiber scheduler *)

(* === External C stubs === *)

(* WiFi control *)
external wifi_connect_raw : string -> string -> int -> int = "ocaml_wifi_connect"
external wifi_disconnect_raw : unit -> unit = "ocaml_wifi_disconnect"
external wifi_is_connected_raw : unit -> int = "ocaml_wifi_is_connected"
external wifi_get_ip_raw : unit -> int = "ocaml_wifi_get_ip"

(* TCP sockets *)
external tcp_create_raw : unit -> int = "ocaml_tcp_create"
external tcp_connect_raw : int -> int -> int -> int = "ocaml_tcp_connect"
external tcp_write_raw : int -> bytes -> int -> int = "ocaml_tcp_write"
external tcp_read_raw : int -> bytes -> int -> int = "ocaml_tcp_read"
external tcp_close_raw : int -> unit = "ocaml_tcp_close"

(* UDP sockets *)
external udp_create_raw : unit -> int = "ocaml_udp_create"
external udp_bind_raw : int -> int -> int = "ocaml_udp_bind"
external udp_sendto_raw : int -> int -> int -> bytes -> int -> int = "ocaml_udp_sendto"
external udp_recvfrom_raw : int -> bytes -> int = "ocaml_udp_recvfrom"
external udp_close_raw : int -> unit = "ocaml_udp_close"

(* DNS resolution *)
external dns_resolve_raw : string -> int = "ocaml_dns_resolve"

(* Network polling and events *)
external net_poll_raw : unit -> unit = "ocaml_net_poll"
external lwip_service_raw : unit -> unit = "ocaml_lwip_service"

(* IP utilities *)
external ip_from_string_raw : string -> int = "ocaml_ip_from_string"
external ip_to_string_raw : int -> string = "ocaml_ip_to_string"

(* Pico timing *)
external sleep_ms : int -> unit = "ocaml_sleep_ms"
external time_ms : unit -> int = "ocaml_time_ms"

(* Debug output *)
external debug_print : string -> unit = "pico_print"
external debug_print_int : int -> unit = "pico_print_int"

(* === Socket types === *)

type tcp_socket = { tcp_id : int }
type udp_socket = { udp_id : int }

(* === Effect types === *)

(* WiFi effects *)
type _ Effect.t += Wifi_connect : (string * string * int) -> unit Effect.t
type _ Effect.t += Wifi_disconnect : unit Effect.t
type _ Effect.t += Wifi_get_ip : string Effect.t

(* TCP effects *)
type _ Effect.t += Tcp_connect : (string * int) -> tcp_socket Effect.t
type _ Effect.t += Tcp_read : tcp_socket -> bytes Effect.t
type _ Effect.t += Tcp_write : (tcp_socket * bytes) -> int Effect.t
type _ Effect.t += Tcp_close : tcp_socket -> unit Effect.t

(* UDP effects *)
type _ Effect.t += Udp_create : udp_socket Effect.t
type _ Effect.t += Udp_bind : (udp_socket * int) -> unit Effect.t
type _ Effect.t += Udp_sendto : (udp_socket * string * int * bytes) -> int Effect.t
type _ Effect.t += Udp_recvfrom : udp_socket -> (bytes * string * int) Effect.t
type _ Effect.t += Udp_close : udp_socket -> unit Effect.t

(* DNS effect *)
type _ Effect.t += Dns_resolve : string -> string Effect.t

(* === Error handling === *)

exception Network_error of string
exception Connection_refused
exception Connection_timeout
exception Socket_closed
exception Dns_failed of string

(* === Helper functions === *)

let ip_to_string ip =
  let b0 = ip land 0xff in
  let b1 = (ip lsr 8) land 0xff in
  let b2 = (ip lsr 16) land 0xff in
  let b3 = (ip lsr 24) land 0xff in
  string_of_int b0 ^ "." ^ string_of_int b1 ^ "." ^
  string_of_int b2 ^ "." ^ string_of_int b3

let ip_from_string s =
  ip_from_string_raw s

(* === Network polling === *)

let service_network () =
  lwip_service_raw ();
  net_poll_raw ()

(* === WiFi module === *)

module Wifi = struct
  let connect ~ssid ~password ?(timeout_ms=30000) () =
    Effect.perform (Wifi_connect (ssid, password, timeout_ms))

  let disconnect () =
    Effect.perform Wifi_disconnect

  let is_connected () =
    wifi_is_connected_raw () <> 0

  let get_ip () =
    Effect.perform Wifi_get_ip
end

(* === TCP module === *)

module Tcp = struct
  type t = tcp_socket

  let connect ~host ~port =
    Effect.perform (Tcp_connect (host, port))

  let read sock =
    Effect.perform (Tcp_read sock)

  let write sock data =
    Effect.perform (Tcp_write (sock, data))

  let close sock =
    Effect.perform (Tcp_close sock)

  let write_string sock s =
    write sock (Bytes.of_string s)
end

(* === UDP module === *)

module Udp = struct
  type t = udp_socket

  let create () =
    Effect.perform Udp_create

  let bind sock ~port =
    Effect.perform (Udp_bind (sock, port))

  let sendto sock ~host ~port data =
    Effect.perform (Udp_sendto (sock, host, port, data))

  let recvfrom sock =
    Effect.perform (Udp_recvfrom sock)

  let close sock =
    Effect.perform (Udp_close sock)

  let sendto_string sock ~host ~port s =
    sendto sock ~host ~port (Bytes.of_string s)
end

(* === DNS module === *)

module Dns = struct
  let resolve hostname =
    Effect.perform (Dns_resolve hostname)
end

(* === Simple blocking run for backward compatibility === *)
(* For non-concurrent use cases, provides blocking effect handlers *)
(* For concurrent networking with fibers, use Pio.run instead *)

let run fn =
  Effect.Deep.match_with fn ()
    { retc = (fun x -> x);
      exnc = raise;
      effc = fun (type c) (eff : c Effect.t) ->
        match eff with
        (* WiFi effects *)
        | Wifi_connect (ssid, password, timeout) ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              let result = wifi_connect_raw ssid password timeout in
              if result = 0 then Effect.Deep.continue k ()
              else Effect.Deep.discontinue k (Network_error "WiFi connection failed"))
        | Wifi_get_ip ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              let ip = wifi_get_ip_raw () in
              Effect.Deep.continue k (ip_to_string ip))
        | Wifi_disconnect ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              wifi_disconnect_raw ();
              Effect.Deep.continue k ())
        (* TCP effects - blocking versions *)
        | Tcp_connect (host, port) ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              let sock_id = tcp_create_raw () in
              if sock_id < 0 then
                Effect.Deep.discontinue k (Network_error "Failed to create TCP socket")
              else begin
                let ip =
                  if String.length host > 0 && host.[0] >= '0' && host.[0] <= '9' then
                    ip_from_string host
                  else dns_resolve_raw host
                in
                if ip = 0 then begin
                  tcp_close_raw sock_id;
                  Effect.Deep.discontinue k (Dns_failed host)
                end else begin
                  let result = tcp_connect_raw sock_id ip port in
                  if result < 0 then begin
                    tcp_close_raw sock_id;
                    Effect.Deep.discontinue k (Network_error "TCP connect failed")
                  end else begin
                    let rec wait_connect timeout_count =
                      service_network ();
                      sleep_ms 10;
                      let test_buf = Bytes.create 0 in
                      let write_result = tcp_write_raw sock_id test_buf 0 in
                      if write_result >= 0 then
                        Effect.Deep.continue k { tcp_id = sock_id }
                      else if timeout_count < 1000 then
                        wait_connect (timeout_count + 1)
                      else begin
                        tcp_close_raw sock_id;
                        Effect.Deep.discontinue k Connection_timeout
                      end
                    in
                    wait_connect 0
                  end
                end
              end)
        | Tcp_write (sock, data) ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              let result = tcp_write_raw sock.tcp_id data (Bytes.length data) in
              service_network ();
              if result >= 0 then Effect.Deep.continue k result
              else Effect.Deep.discontinue k (Network_error "TCP write failed"))
        | Tcp_read sock ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              let buf = Bytes.create 4096 in
              let rec recv_loop timeout_count =
                service_network ();
                let n = tcp_read_raw sock.tcp_id buf (Bytes.length buf) in
                if n > 0 then Effect.Deep.continue k (Bytes.sub buf 0 n)
                else if n = -2 then Effect.Deep.discontinue k Socket_closed
                else if timeout_count < 1000 then begin
                  sleep_ms 10;
                  recv_loop (timeout_count + 1)
                end else Effect.Deep.discontinue k (Network_error "TCP read timeout")
              in recv_loop 0)
        | Tcp_close sock ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              tcp_close_raw sock.tcp_id;
              Effect.Deep.continue k ())
        (* UDP effects *)
        | Udp_create ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              let sock_id = udp_create_raw () in
              if sock_id >= 0 then Effect.Deep.continue k { udp_id = sock_id }
              else Effect.Deep.discontinue k (Network_error "Failed to create UDP socket"))
        | Udp_bind (sock, port) ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              let result = udp_bind_raw sock.udp_id port in
              if result = 0 then Effect.Deep.continue k ()
              else Effect.Deep.discontinue k (Network_error "Bind failed"))
        | Udp_sendto (sock, host, port, data) ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              let ip =
                if String.length host > 0 && host.[0] >= '0' && host.[0] <= '9' then
                  ip_from_string host
                else dns_resolve_raw host
              in
              if ip = 0 then Effect.Deep.discontinue k (Dns_failed host)
              else begin
                let result = udp_sendto_raw sock.udp_id ip port data (Bytes.length data) in
                service_network ();
                if result >= 0 then Effect.Deep.continue k result
                else Effect.Deep.discontinue k (Network_error "UDP send failed")
              end)
        | Udp_recvfrom sock ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              let buf = Bytes.create 4096 in
              let rec recv_loop timeout_count =
                service_network ();
                let n = udp_recvfrom_raw sock.udp_id buf in
                if n > 0 then Effect.Deep.continue k (Bytes.sub buf 0 n, "0.0.0.0", 0)
                else if timeout_count < 1000 then begin
                  sleep_ms 10;
                  recv_loop (timeout_count + 1)
                end else Effect.Deep.discontinue k (Network_error "UDP receive timeout")
              in recv_loop 0)
        | Udp_close sock ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              udp_close_raw sock.udp_id;
              Effect.Deep.continue k ())
        (* DNS effect *)
        | Dns_resolve hostname ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              let ip = dns_resolve_raw hostname in
              if ip = 0 then Effect.Deep.discontinue k (Dns_failed hostname)
              else Effect.Deep.continue k (ip_to_string ip))
        (* Unhandled effects *)
        | _ -> None
    }
