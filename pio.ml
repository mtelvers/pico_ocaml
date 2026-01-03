(* pio.ml - Eio-compatible effects library for Pico 2 W *)
(* Provides cooperative fiber scheduling with direct-style async I/O *)
(* Handles both Pio fiber effects AND Net network effects *)

(* === External C stubs === *)
external sleep_ms : int -> unit = "ocaml_sleep_ms"
external time_ms : unit -> int = "ocaml_time_ms"
external debug_print : string -> unit = "pico_print"
external debug_print_int : int -> unit = "pico_print_int"

(* Network externals - needed for effect handling *)
external wifi_connect_raw : string -> string -> int -> int = "ocaml_wifi_connect"
external wifi_disconnect_raw : unit -> unit = "ocaml_wifi_disconnect"
external wifi_get_ip_raw : unit -> int = "ocaml_wifi_get_ip"
external tcp_create_raw : unit -> int = "ocaml_tcp_create"
external tcp_connect_raw : int -> int -> int -> int = "ocaml_tcp_connect"
external tcp_write_raw : int -> bytes -> int -> int = "ocaml_tcp_write"
external tcp_read_raw : int -> bytes -> int -> int = "ocaml_tcp_read"
external tcp_close_raw : int -> unit = "ocaml_tcp_close"
external udp_create_raw : unit -> int = "ocaml_udp_create"
external udp_bind_raw : int -> int -> int = "ocaml_udp_bind"
external udp_sendto_raw : int -> int -> int -> bytes -> int -> int = "ocaml_udp_sendto"
external udp_recvfrom_raw : int -> bytes -> int = "ocaml_udp_recvfrom"
external udp_close_raw : int -> unit = "ocaml_udp_close"
external dns_resolve_raw : string -> int = "ocaml_dns_resolve"
external net_poll_raw : unit -> unit = "ocaml_net_poll"
external lwip_service_raw : unit -> unit = "ocaml_lwip_service"
external ip_from_string_raw : string -> int = "ocaml_ip_from_string"

(* === Promise types === *)
type 'a promise_state =
  | Pending of (unit -> unit) list
  | Resolved of 'a
  | Failed of exn

type 'a promise = { mutable state : 'a promise_state }

(* === Switch types === *)
type switch = {
  id : int;
  mutable fibers : int;
  mutable on_release : (unit -> unit) list;
  mutable finished : bool;
}

(* === Run queue === *)
let run_queue : (unit -> unit) Queue.t = Queue.create ()

(* === I/O wait state === *)
type io_waiter = {
  sock_id : int;
  operation : [`Connect | `Read];
  timeout_count : int;  (* Immutable - create new record to increment *)
  max_timeout : int;
  wake : unit -> unit;
  on_timeout : unit -> unit;
}

let io_waiters : io_waiter list ref = ref []

(* === Global state === *)
(* Note: Some refs are inherent to cooperative scheduling (run_queue, io_waiters, promises).
   Switch ID generation uses a simple counter ref - acceptable for unique IDs. *)
let next_switch_id = ref 0

let fresh_id () =
  let id = !next_switch_id in
  next_switch_id := id + 1;
  id

let enqueue f = Queue.add f run_queue

(* === Effect types (Pio effects) === *)
type _ Effect.t += Fork : (switch * (unit -> unit)) -> unit Effect.t
type _ Effect.t += Fork_promise : (switch * (unit -> 'a)) -> ('a, exn) result promise Effect.t
type _ Effect.t += Await : 'a promise -> 'a Effect.t
type _ Effect.t += Yield : unit Effect.t

(* === Helper functions === *)
let ip_to_string ip =
  let b0 = ip land 0xff in
  let b1 = (ip lsr 8) land 0xff in
  let b2 = (ip lsr 16) land 0xff in
  let b3 = (ip lsr 24) land 0xff in
  string_of_int b0 ^ "." ^ string_of_int b1 ^ "." ^
  string_of_int b2 ^ "." ^ string_of_int b3

let service_network () =
  lwip_service_raw ();
  net_poll_raw ()

(* Helper: resolve hostname or parse IP address *)
let resolve_host host =
  if String.length host > 0 && host.[0] >= '0' && host.[0] <= '9'
  then ip_from_string_raw host
  else dns_resolve_raw host

(* === Promise module === *)
module Promise = struct
  type 'a t = 'a promise
  type 'a or_exn = ('a, exn) result t

  let create () : 'a t = { state = Pending [] }

  let resolve p v =
    match p.state with
    | Pending waiters ->
        p.state <- Resolved v;
        List.iter enqueue waiters
    | _ -> ()

  let fail p e =
    match p.state with
    | Pending waiters ->
        p.state <- Failed e;
        List.iter enqueue waiters
    | _ -> ()

  let add_waiter p waker =
    match p.state with
    | Pending waiters -> p.state <- Pending (waker :: waiters)
    | _ -> enqueue waker

  let await p = Effect.perform (Await p)

  let await_exn p =
    match await p with
    | Ok v -> v
    | Error e -> raise e
end

(* === Forward declaration for scheduler === *)
let scheduler_ref : (switch -> unit) ref = ref (fun _ -> ())

(* === Switch module === *)
module Switch = struct
  type t = switch

  let fiber_done sw =
    sw.fibers <- sw.fibers - 1

  let on_release sw f =
    sw.on_release <- f :: sw.on_release

  let run_ref : ((switch -> 'a) -> 'a) ref = ref (fun _ -> failwith "not initialized")

  let run fn = !run_ref fn
end

(* === Fiber module === *)
module Fiber = struct
  let fork ~sw fn = Effect.perform (Fork (sw, fn))
  let fork_promise ~sw fn = Effect.perform (Fork_promise (sw, fn))
  let yield () = Effect.perform Yield

  let both f g =
    let p1 = Promise.create () in
    let p2 = Promise.create () in
    enqueue (fun () ->
      begin try Promise.resolve p1 (f ()) with e -> Promise.fail p1 e end);
    enqueue (fun () ->
      begin try Promise.resolve p2 (g ()) with e -> Promise.fail p2 e end);
    let _ = Promise.await p1 in
    let _ = Promise.await p2 in
    ()

  let all fns =
    let promises = List.map (fun f ->
      let p = Promise.create () in
      enqueue (fun () ->
        begin try Promise.resolve p (f ()) with e -> Promise.fail p e end);
      p
    ) fns in
    List.iter (fun p -> let _ = Promise.await p in ()) promises
end

(* === I/O completion checking === *)
(* Uses fold_left for functional accumulation instead of refs *)
let check_io_completions () =
  service_network ();
  let process_waiter (remaining, to_wake) w =
    let is_ready = match w.operation with
      | `Connect ->
          tcp_write_raw w.sock_id (Bytes.create 0) 0 >= 0
      | `Read ->
          let n = tcp_read_raw w.sock_id (Bytes.create 1) 0 in
          n > 0 || n = -2
    in
    match is_ready, w.timeout_count >= w.max_timeout with
    | true, _ ->
        (* Ready - wake the fiber *)
        (remaining, w.wake :: to_wake)
    | false, true ->
        (* Timed out - call timeout handler *)
        (remaining, w.on_timeout :: to_wake)
    | false, false ->
        (* Still waiting - increment timeout and keep in list *)
        ({ w with timeout_count = w.timeout_count + 1 } :: remaining, to_wake)
  in
  let remaining, to_wake = List.fold_left process_waiter ([], []) !io_waiters in
  io_waiters := remaining;
  List.iter enqueue to_wake

(* === Effect handler for network effects === *)
(* Returns None if effect not handled, Some handler otherwise *)
let handle_net_effect : type c. switch -> c Effect.t -> ((c, unit) Effect.Deep.continuation -> unit) option =
  fun sw eff ->
    match eff with
    (* === Net WiFi effects === *)
    | Net.Wifi_connect (ssid, password, timeout) ->
        Some (fun k ->
          let result = wifi_connect_raw ssid password timeout in
          if result = 0 then Effect.Deep.continue k ()
          else Effect.Deep.discontinue k (Net.Network_error "WiFi connection failed"))
    | Net.Wifi_get_ip ->
        Some (fun k ->
          let ip = wifi_get_ip_raw () in
          Effect.Deep.continue k (ip_to_string ip))
    | Net.Wifi_disconnect ->
        Some (fun k ->
          wifi_disconnect_raw ();
          Effect.Deep.continue k ())

    (* === Net TCP effects === *)
    | Net.Tcp_connect (host, port) ->
        Some (fun k ->
          let sock_id = tcp_create_raw () in
          match sock_id < 0 with
          | true ->
              Effect.Deep.discontinue k (Net.Network_error "Failed to create TCP socket")
          | false ->
              let ip = resolve_host host in
              match ip = 0 with
              | true ->
                  tcp_close_raw sock_id;
                  Effect.Deep.discontinue k (Net.Dns_failed host)
              | false ->
                  match tcp_connect_raw sock_id ip port < 0 with
                  | true ->
                      tcp_close_raw sock_id;
                      Effect.Deep.discontinue k (Net.Network_error "TCP connect failed")
                  | false ->
                      let waiter = {
                        sock_id;
                        operation = `Connect;
                        timeout_count = 0;
                        max_timeout = 1000;
                        wake = (fun () ->
                          enqueue (fun () -> Effect.Deep.continue k { Net.tcp_id = sock_id }));
                        on_timeout = (fun () ->
                          tcp_close_raw sock_id;
                          enqueue (fun () -> Effect.Deep.discontinue k Net.Connection_timeout));
                      } in
                      io_waiters := waiter :: !io_waiters;
                      !scheduler_ref sw)
    | Net.Tcp_write (sock, data) ->
        Some (fun k ->
          let result = tcp_write_raw sock.Net.tcp_id data (Bytes.length data) in
          service_network ();
          if result >= 0 then Effect.Deep.continue k result
          else Effect.Deep.discontinue k (Net.Network_error "TCP write failed"))
    | Net.Tcp_read sock ->
        Some (fun k ->
          let buf = Bytes.create 4096 in
          service_network ();
          let n = tcp_read_raw sock.Net.tcp_id buf (Bytes.length buf) in
          match n with
          | _ when n > 0 -> Effect.Deep.continue k (Bytes.sub buf 0 n)
          | -2 -> Effect.Deep.discontinue k Net.Socket_closed
          | _ ->
              (* No data yet - register waiter for async completion *)
              let handle_read_result n2 =
                match n2 with
                | _ when n2 > 0 ->
                    enqueue (fun () -> Effect.Deep.continue k (Bytes.sub buf 0 n2))
                | -2 ->
                    enqueue (fun () -> Effect.Deep.discontinue k Net.Socket_closed)
                | _ ->
                    enqueue (fun () -> Effect.Deep.discontinue k (Net.Network_error "TCP read failed"))
              in
              let waiter = {
                sock_id = sock.Net.tcp_id;
                operation = `Read;
                timeout_count = 0;
                max_timeout = 1000;
                wake = (fun () ->
                  handle_read_result (tcp_read_raw sock.Net.tcp_id buf (Bytes.length buf)));
                on_timeout = (fun () ->
                  enqueue (fun () -> Effect.Deep.discontinue k (Net.Network_error "TCP read timeout")));
              } in
              io_waiters := waiter :: !io_waiters;
              !scheduler_ref sw)
    | Net.Tcp_close sock ->
        Some (fun k ->
          io_waiters := List.filter (fun w -> w.sock_id <> sock.Net.tcp_id) !io_waiters;
          tcp_close_raw sock.Net.tcp_id;
          Effect.Deep.continue k ())

    (* === Net UDP effects === *)
    | Net.Udp_create ->
        Some (fun k ->
          let sock_id = udp_create_raw () in
          if sock_id >= 0 then Effect.Deep.continue k { Net.udp_id = sock_id }
          else Effect.Deep.discontinue k (Net.Network_error "Failed to create UDP socket"))
    | Net.Udp_bind (sock, port) ->
        Some (fun k ->
          let result = udp_bind_raw sock.Net.udp_id port in
          if result = 0 then Effect.Deep.continue k ()
          else Effect.Deep.discontinue k (Net.Network_error "Bind failed"))
    | Net.Udp_sendto (sock, host, port, data) ->
        Some (fun k ->
          let ip = resolve_host host in
          match ip = 0 with
          | true -> Effect.Deep.discontinue k (Net.Dns_failed host)
          | false ->
              let result = udp_sendto_raw sock.Net.udp_id ip port data (Bytes.length data) in
              service_network ();
              match result >= 0 with
              | true -> Effect.Deep.continue k result
              | false -> Effect.Deep.discontinue k (Net.Network_error "UDP send failed"))
    | Net.Udp_recvfrom sock ->
        Some (fun k ->
          let buf = Bytes.create 4096 in
          (* Tail-recursive receive loop with explicit timeout counter *)
          let rec recv_loop timeout_count =
            service_network ();
            let n = udp_recvfrom_raw sock.Net.udp_id buf in
            match n > 0, timeout_count < 1000 with
            | true, _ -> Effect.Deep.continue k (Bytes.sub buf 0 n, "0.0.0.0", 0)
            | false, true ->
                sleep_ms 10;
                recv_loop (timeout_count + 1)
            | false, false -> Effect.Deep.discontinue k (Net.Network_error "UDP receive timeout")
          in
          recv_loop 0)
    | Net.Udp_close sock ->
        Some (fun k ->
          udp_close_raw sock.Net.udp_id;
          Effect.Deep.continue k ())

    (* === Net DNS effect === *)
    | Net.Dns_resolve hostname ->
        Some (fun k ->
          let ip = dns_resolve_raw hostname in
          if ip = 0 then Effect.Deep.discontinue k (Net.Dns_failed hostname)
          else Effect.Deep.continue k (ip_to_string ip))

    | _ -> None

(* === Run a unit-returning fiber === *)
let rec run_fiber sw f =
  Effect.Deep.match_with f ()
    { Effect.Deep.retc = (fun () ->
        Switch.fiber_done sw;
        !scheduler_ref sw);
      exnc = (fun _e ->
        Switch.fiber_done sw;
        !scheduler_ref sw);
      effc = fun (type c) (eff : c Effect.t) ->
        match eff with
        | Fork (sw', f') ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              sw'.fibers <- sw'.fibers + 1;
              enqueue (fun () -> run_fiber sw' f');
              Effect.Deep.continue k ())
        | Fork_promise (sw', f') ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              let p = Promise.create () in
              sw'.fibers <- sw'.fibers + 1;
              enqueue (fun () -> run_promise_fiber sw' f' p);
              Effect.Deep.continue k p)
        | Await p ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              match p.state with
              | Resolved v -> Effect.Deep.continue k v
              | Failed e -> Effect.Deep.discontinue k e
              | Pending _ ->
                  Promise.add_waiter p (fun () ->
                    match p.state with
                    | Resolved v -> enqueue (fun () -> Effect.Deep.continue k v)
                    | Failed e -> enqueue (fun () -> Effect.Deep.discontinue k e)
                    | Pending _ -> failwith "Promise still pending");
                  !scheduler_ref sw)
        | Yield ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              enqueue (fun () -> Effect.Deep.continue k ());
              !scheduler_ref sw)
        | _ ->
            match handle_net_effect sw eff with
            | Some handler -> Some handler
            | None -> None
    }

(* === Run a fiber that returns a value into a promise === *)
and run_promise_fiber : type a. switch -> (unit -> a) -> (a, exn) result promise -> unit =
  fun sw f p ->
    Effect.Deep.match_with f ()
      { Effect.Deep.retc = (fun r ->
          Promise.resolve p (Ok r);
          Switch.fiber_done sw;
          !scheduler_ref sw);
        exnc = (fun e ->
          Promise.resolve p (Error e);
          Switch.fiber_done sw;
          !scheduler_ref sw);
        effc = fun (type c) (eff : c Effect.t) ->
          match eff with
          | Fork (sw', f') ->
              Some (fun (k : (c, _) Effect.Deep.continuation) ->
                sw'.fibers <- sw'.fibers + 1;
                enqueue (fun () -> run_fiber sw' f');
                Effect.Deep.continue k ())
          | Fork_promise (sw', f') ->
              Some (fun (k : (c, _) Effect.Deep.continuation) ->
                let p' = Promise.create () in
                sw'.fibers <- sw'.fibers + 1;
                enqueue (fun () -> run_promise_fiber sw' f' p');
                Effect.Deep.continue k p')
          | Await p' ->
              Some (fun (k : (c, _) Effect.Deep.continuation) ->
                match p'.state with
                | Resolved v -> Effect.Deep.continue k v
                | Failed e -> Effect.Deep.discontinue k e
                | Pending _ ->
                    Promise.add_waiter p' (fun () ->
                      match p'.state with
                      | Resolved v -> enqueue (fun () -> Effect.Deep.continue k v)
                      | Failed e -> enqueue (fun () -> Effect.Deep.discontinue k e)
                      | Pending _ -> failwith "Promise still pending");
                    !scheduler_ref sw)
          | Yield ->
              Some (fun (k : (c, _) Effect.Deep.continuation) ->
                enqueue (fun () -> Effect.Deep.continue k ());
                !scheduler_ref sw)
          | _ ->
              match handle_net_effect sw eff with
              | Some handler -> Some handler
              | None -> None
      }

(* === Main scheduler loop === *)
and scheduler sw =
  check_io_completions ();
  match Queue.take_opt run_queue with
  | Some task ->
      task ();
      scheduler sw  (* Must recurse to process more tasks *)
  | None ->
      if sw.fibers > 0 || !io_waiters <> [] then begin
        service_network ();
        sleep_ms 1;
        scheduler sw
      end

let () = scheduler_ref := scheduler

(* === Switch.run implementation === *)
(* Uses a different approach: enqueue the main fiber and run scheduler *)
let switch_run fn =
  let sw = {
    id = fresh_id ();
    fibers = 1;
    on_release = [];
    finished = false;
  } in
  let result = ref None in
  let exn_ref = ref None in

  (* Create a handler for the main fiber that captures result *)
  let rec main_handler =
    { Effect.Deep.retc = (fun r ->
        result := Some r;
        Switch.fiber_done sw);
      exnc = (fun e ->
        exn_ref := Some e;
        Switch.fiber_done sw);
      effc = fun (type c) (eff : c Effect.t) ->
        match eff with
        | Fork (sw', f) ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              sw'.fibers <- sw'.fibers + 1;
              enqueue (fun () -> run_fiber sw' f);
              Effect.Deep.continue k ())
        | Fork_promise (sw', f) ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              let p = Promise.create () in
              sw'.fibers <- sw'.fibers + 1;
              enqueue (fun () -> run_promise_fiber sw' f p);
              Effect.Deep.continue k p)
        | Await p ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              match p.state with
              | Resolved v -> Effect.Deep.continue k v
              | Failed e -> Effect.Deep.discontinue k e
              | Pending _ ->
                  (* When promise resolves, enqueue continuation wrapped in main handler *)
                  Promise.add_waiter p (fun () ->
                    match p.state with
                    | Resolved v ->
                        enqueue (fun () ->
                          Effect.Deep.match_with (fun () -> Effect.Deep.continue k v) () main_handler)
                    | Failed e ->
                        enqueue (fun () ->
                          Effect.Deep.match_with (fun () -> Effect.Deep.discontinue k e) () main_handler)
                    | Pending _ -> failwith "Promise still pending")
                  (* Don't call scheduler - just return, let main scheduler loop continue *))
        | Yield ->
            Some (fun (k : (c, _) Effect.Deep.continuation) ->
              enqueue (fun () ->
                Effect.Deep.match_with (fun () -> Effect.Deep.continue k ()) () main_handler)
              (* Return without calling scheduler *))
        | _ ->
            (* Handle net effects - but modify to not call scheduler *)
            match eff with
            | Net.Wifi_connect (ssid, password, timeout) ->
                Some (fun (k : (c, _) Effect.Deep.continuation) ->
                  let r = wifi_connect_raw ssid password timeout in
                  if r = 0 then Effect.Deep.continue k ()
                  else Effect.Deep.discontinue k (Net.Network_error "WiFi connection failed"))
            | Net.Wifi_get_ip ->
                Some (fun (k : (c, _) Effect.Deep.continuation) ->
                  let ip = wifi_get_ip_raw () in
                  Effect.Deep.continue k (ip_to_string ip))
            | Net.Wifi_disconnect ->
                Some (fun (k : (c, _) Effect.Deep.continuation) ->
                  wifi_disconnect_raw ();
                  Effect.Deep.continue k ())
            | Net.Tcp_connect (host, port) ->
                Some (fun (k : (c, _) Effect.Deep.continuation) ->
                  let sock_id = tcp_create_raw () in
                  match sock_id < 0 with
                  | true ->
                      Effect.Deep.discontinue k (Net.Network_error "Failed to create TCP socket")
                  | false ->
                      let ip = resolve_host host in
                      match ip = 0 with
                      | true ->
                          tcp_close_raw sock_id;
                          Effect.Deep.discontinue k (Net.Dns_failed host)
                      | false ->
                          match tcp_connect_raw sock_id ip port < 0 with
                          | true ->
                              tcp_close_raw sock_id;
                              Effect.Deep.discontinue k (Net.Network_error "TCP connect failed")
                          | false ->
                              let waiter = {
                                sock_id;
                                operation = `Connect;
                                timeout_count = 0;
                                max_timeout = 1000;
                                wake = (fun () ->
                                  enqueue (fun () ->
                                    Effect.Deep.match_with
                                      (fun () -> Effect.Deep.continue k { Net.tcp_id = sock_id })
                                      () main_handler));
                                on_timeout = (fun () ->
                                  tcp_close_raw sock_id;
                                  enqueue (fun () ->
                                    Effect.Deep.match_with
                                      (fun () -> Effect.Deep.discontinue k Net.Connection_timeout)
                                      () main_handler));
                              } in
                              io_waiters := waiter :: !io_waiters)
            | Net.Tcp_write (sock, data) ->
                Some (fun (k : (c, _) Effect.Deep.continuation) ->
                  let r = tcp_write_raw sock.Net.tcp_id data (Bytes.length data) in
                  service_network ();
                  if r >= 0 then Effect.Deep.continue k r
                  else Effect.Deep.discontinue k (Net.Network_error "TCP write failed"))
            | Net.Tcp_read sock ->
                Some (fun (k : (c, _) Effect.Deep.continuation) ->
                  let buf = Bytes.create 4096 in
                  service_network ();
                  let n = tcp_read_raw sock.Net.tcp_id buf (Bytes.length buf) in
                  match n with
                  | _ when n > 0 -> Effect.Deep.continue k (Bytes.sub buf 0 n)
                  | -2 -> Effect.Deep.discontinue k Net.Socket_closed
                  | _ ->
                      (* No data yet - register waiter for async completion *)
                      let handle_read_result n2 =
                        match n2 with
                        | _ when n2 > 0 ->
                            enqueue (fun () ->
                              Effect.Deep.match_with
                                (fun () -> Effect.Deep.continue k (Bytes.sub buf 0 n2))
                                () main_handler)
                        | -2 ->
                            enqueue (fun () ->
                              Effect.Deep.match_with
                                (fun () -> Effect.Deep.discontinue k Net.Socket_closed)
                                () main_handler)
                        | _ ->
                            enqueue (fun () ->
                              Effect.Deep.match_with
                                (fun () -> Effect.Deep.discontinue k (Net.Network_error "TCP read failed"))
                                () main_handler)
                      in
                      let waiter = {
                        sock_id = sock.Net.tcp_id;
                        operation = `Read;
                        timeout_count = 0;
                        max_timeout = 1000;
                        wake = (fun () ->
                          handle_read_result (tcp_read_raw sock.Net.tcp_id buf (Bytes.length buf)));
                        on_timeout = (fun () ->
                          enqueue (fun () ->
                            Effect.Deep.match_with
                              (fun () -> Effect.Deep.discontinue k (Net.Network_error "TCP read timeout"))
                              () main_handler));
                      } in
                      io_waiters := waiter :: !io_waiters)
            | Net.Tcp_close sock ->
                Some (fun (k : (c, _) Effect.Deep.continuation) ->
                  io_waiters := List.filter (fun w -> w.sock_id <> sock.Net.tcp_id) !io_waiters;
                  tcp_close_raw sock.Net.tcp_id;
                  Effect.Deep.continue k ())
            | Net.Udp_create ->
                Some (fun (k : (c, _) Effect.Deep.continuation) ->
                  let sock_id = udp_create_raw () in
                  if sock_id >= 0 then Effect.Deep.continue k { Net.udp_id = sock_id }
                  else Effect.Deep.discontinue k (Net.Network_error "Failed to create UDP socket"))
            | Net.Udp_bind (sock, port) ->
                Some (fun (k : (c, _) Effect.Deep.continuation) ->
                  let r = udp_bind_raw sock.Net.udp_id port in
                  if r = 0 then Effect.Deep.continue k ()
                  else Effect.Deep.discontinue k (Net.Network_error "Bind failed"))
            | Net.Udp_sendto (sock, host, port, data) ->
                Some (fun (k : (c, _) Effect.Deep.continuation) ->
                  let ip = resolve_host host in
                  match ip = 0 with
                  | true -> Effect.Deep.discontinue k (Net.Dns_failed host)
                  | false ->
                      let r = udp_sendto_raw sock.Net.udp_id ip port data (Bytes.length data) in
                      service_network ();
                      match r >= 0 with
                      | true -> Effect.Deep.continue k r
                      | false -> Effect.Deep.discontinue k (Net.Network_error "UDP send failed"))
            | Net.Udp_recvfrom sock ->
                Some (fun (k : (c, _) Effect.Deep.continuation) ->
                  let buf = Bytes.create 4096 in
                  (* Tail-recursive receive loop with explicit timeout counter *)
                  let rec recv_loop timeout_count =
                    service_network ();
                    let n = udp_recvfrom_raw sock.Net.udp_id buf in
                    match n > 0, timeout_count < 1000 with
                    | true, _ -> Effect.Deep.continue k (Bytes.sub buf 0 n, "0.0.0.0", 0)
                    | false, true ->
                        sleep_ms 10;
                        recv_loop (timeout_count + 1)
                    | false, false -> Effect.Deep.discontinue k (Net.Network_error "UDP receive timeout")
                  in
                  recv_loop 0)
            | Net.Udp_close sock ->
                Some (fun (k : (c, _) Effect.Deep.continuation) ->
                  udp_close_raw sock.Net.udp_id;
                  Effect.Deep.continue k ())
            | Net.Dns_resolve hostname ->
                Some (fun (k : (c, _) Effect.Deep.continuation) ->
                  let ip = dns_resolve_raw hostname in
                  if ip = 0 then Effect.Deep.discontinue k (Net.Dns_failed hostname)
                  else Effect.Deep.continue k (ip_to_string ip))
            | _ -> None
    }
  in

  (* Enqueue the main fiber *)
  enqueue (fun () -> Effect.Deep.match_with (fun () -> fn sw) () main_handler);

  (* Main scheduler loop - runs until main fiber completes *)
  let rec main_scheduler () =
    check_io_completions ();
    match Queue.take_opt run_queue with
    | Some task ->
        task ();
        main_scheduler ()
    | None ->
        (* Check if main fiber completed *)
        if !result <> None || !exn_ref <> None then
          ()  (* Done! *)
        else if sw.fibers > 0 || !io_waiters <> [] then begin
          service_network ();
          sleep_ms 1;
          main_scheduler ()
        end else
          ()  (* No more work - will error below *)
  in
  main_scheduler ();

  (* Cleanup *)
  sw.finished <- true;
  List.iter (fun f -> try f () with _ -> ()) sw.on_release;

  (* Return result *)
  match !exn_ref with
  | Some e -> raise e
  | None ->
      match !result with
      | Some r -> r
      | None -> failwith "Switch.run: main fiber did not complete"

let () = Switch.run_ref := switch_run

(* === Convenience entry point === *)
let run fn = Switch.run fn
