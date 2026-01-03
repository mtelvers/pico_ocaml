(* Dual-core demo: Pio effects on Core 0 + Domain.spawn on Core 1 *)
(* Demonstrates true parallelism: network I/O + CPU computation simultaneously *)

external print_string : string -> unit = "pico_print_string"
external print_endline : string -> unit = "pico_print"
external print_int : int -> unit = "pico_print_int"
external sleep_ms : int -> unit = "ocaml_sleep_ms"
external cyw43_init : unit -> int = "ocaml_cyw43_init"
external cyw43_led_set : bool -> unit = "ocaml_cyw43_led_set"
external time_ms : unit -> int = "ocaml_time_ms"

let wifi_ssid = "SSID"
let wifi_password = "PASSWORD"

(* Read all data from socket until closed *)
let read_all sock =
  let rec loop acc =
    match Net.Tcp.read sock with
    | chunk when Bytes.length chunk > 0 ->
        loop (chunk :: acc)
    | _ -> List.rev acc
    | exception Net.Socket_closed ->
        List.rev acc
    | exception _ ->
        List.rev acc
  in
  loop []

(* Combine list of byte chunks into single bytes *)
let concat_chunks chunks =
  let total = List.fold_left (fun acc chunk -> acc + Bytes.length chunk) 0 chunks in
  let result = Bytes.create total in
  let _ = List.fold_left (fun pos chunk ->
    let len = Bytes.length chunk in
    Bytes.blit chunk 0 result pos len;
    pos + len
  ) 0 chunks in
  result

(* Find HTTP body after header separator *)
let find_body response =
  let len = String.length response in
  let rec find i =
    if i + 3 >= len then len
    else if response.[i] = '\r' && response.[i+1] = '\n'
         && response.[i+2] = '\r' && response.[i+3] = '\n'
    then i + 4
    else find (i + 1)
  in
  let start = find 0 in
  String.sub response start (len - start)

(* HTTP GET request to a host - uses Pio effects, runs on Core 0 *)
let http_get ~name host path =
  print_string "[Core0:";
  print_string name;
  print_endline "] Connecting...";
  let sock = Net.Tcp.connect ~host ~port:80 in
  print_string "[Core0:";
  print_string name;
  print_endline "] Connected!";

  let request = "GET " ^ path ^ " HTTP/1.0\r\nHost: " ^ host ^ "\r\nUser-Agent: curl/8.0\r\nAccept: */*\r\n\r\n" in
  let _ = Net.Tcp.write_string sock request in
  print_string "[Core0:";
  print_string name;
  print_endline "] Request sent, reading...";

  let chunks = read_all sock in
  let response = concat_chunks chunks in
  Net.Tcp.close sock;

  print_string "[Core0:";
  print_string name;
  print_string "] Done! ";
  print_int (Bytes.length response);
  print_endline " bytes";

  find_body (Bytes.to_string response)

(* CPU-intensive computation - runs on Core 1 via Domain.spawn *)
(* Computes sum of prime counts up to n using trial division *)
let count_primes_up_to n =
  let is_prime num =
    if num < 2 then false
    else
      let rec check d =
        if d * d > num then true
        else if num mod d = 0 then false
        else check (d + 1)
      in
      check 2
  in
  let rec count acc i =
    if i > n then acc
    else count (if is_prime i then acc + 1 else acc) (i + 1)
  in
  count 0 2

(* Blink LED n times *)
let rec blink_led = function
  | 0 -> ()
  | n ->
      cyw43_led_set true;
      sleep_ms 100;
      cyw43_led_set false;
      sleep_ms 100;
      blink_led (n - 1)

let () =
  print_endline "=== Dual-Core Demo: Pio + Domain.spawn ===";
  print_endline "";

  print_endline "1. Init CYW43...";
  let _ = cyw43_init () in
  print_endline "   Done";

  (* Use Pio.run for networking on Core 0 *)
  Pio.run (fun sw ->
    print_endline "2. WiFi connect...";
    Net.Wifi.connect ~ssid:wifi_ssid ~password:wifi_password ();
    print_string "   Local IP: ";
    print_endline (Net.Wifi.get_ip ());
    print_endline "";

    print_endline "3. Starting parallel work:";
    print_endline "   - Core 0: HTTP fetch (I/O bound)";
    print_endline "   - Core 1: Prime counting (CPU bound)";
    print_endline "";
    let start_time = time_ms () in

    (* Free up memory before spawning second domain *)
    Gc.full_major ();

    (* Spawn CPU work on Core 1 using Domain.spawn *)
    (* This runs OUTSIDE Pio - pure computation, no effects *)
    let domain_handle = Domain.spawn (fun () ->
      (* Count primes up to 50000 - takes ~100-200ms on Cortex-M33 *)
      let result = count_primes_up_to 50000 in
      result
    ) in

    (* Meanwhile, fork HTTP fetch as Pio fiber on Core 0 *)
    let http_promise = Pio.Fiber.fork_promise ~sw (fun () ->
      http_get ~name:"HTTP" "example.com" "/"
    ) in

    (* Wait for both to complete *)
    print_endline "4. Waiting for results...";

    (* Get HTTP result (may involve waiting for I/O) *)
    let http_result = Pio.Promise.await_exn http_promise in

    (* Join the domain (wait for Core 1 to finish) *)
    let prime_count = Domain.join domain_handle in

    let elapsed = time_ms () - start_time in
    print_endline "";
    print_endline "=== Results ===";
    print_string "HTTP response: ";
    print_int (String.length http_result);
    print_endline " chars";
    print_string "Primes <= 50000: ";
    print_int prime_count;
    print_endline "";
    print_string "Total time: ";
    print_int elapsed;
    print_endline " ms";
    print_endline "";
    print_endline "(If parallel, time ~= max(HTTP, primes), not sum)";

    print_endline "";
    print_endline "=== Success! ===";
    blink_led 5
  );

  print_endline "";
  print_endline "=== Done ===";
  cyw43_led_set true
