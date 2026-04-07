(* Digital clock on 20x4 HD44780 LCD *)
(* Dual-core: Domain 1 updates display, Domain 0 handles NTP sync *)

external print_endline : string -> unit = "pico_print"
external print_string : string -> unit = "pico_print_string"
external print_int : int -> unit = "pico_print_int"
external sleep_ms : int -> unit = "ocaml_sleep_ms"
external time_ms : unit -> int = "ocaml_time_ms"
external cyw43_init : unit -> int = "ocaml_cyw43_init"
external pwm_init : int -> int -> int -> unit = "ocaml_pwm_init"
external sleep_us : int -> unit = "ocaml_sleep_us"

let wifi_ssid = "SSID"
let wifi_password = "PASSWORD"

(* UTC offset in hours (e.g. 1 for BST) *)
let utc_offset_hours = 1

(* NTP re-sync interval in milliseconds (1 minute for testing) *)
let resync_interval_ms = 60000

let print_int_02 n =
  if n < 10 then print_string "0";
  print_int n

(* Shared time state between domains *)
let base_secs = Atomic.make 0
let sync_ms = Atomic.make 0

(* NTP query - must be called inside Net.run. Returns Some (h, m, s) or None *)
let ntp_query () =
  match Net.Udp.create () with
  | exception _ -> None
  | sock ->
    Net.Udp.bind sock ~port:0;
    let result =
      try
        let packet = Bytes.make 48 '\000' in
        Bytes.set packet 0 (Char.chr 0x1B);
        let _ = Net.Udp.sendto sock ~host:"pool.ntp.org" ~port:123 packet in
        let (response, _, _) = Net.Udp.recvfrom sock in
        let b0 = Char.code (Bytes.get response 40) in
        let b1 = Char.code (Bytes.get response 41) in
        let b2 = Char.code (Bytes.get response 42) in
        let b3 = Char.code (Bytes.get response 43) in
        let raw = b0 * 15616 + b1 * 65536 + b2 * 256 + b3 in
        let secs_of_day = raw mod 86400 in
        let secs_wrapped = (secs_of_day + utc_offset_hours * 3600) mod 86400 in
        Some (secs_wrapped / 3600, (secs_wrapped mod 3600) / 60, secs_wrapped mod 60)
      with _ -> None
    in
    Net.Udp.close sock;
    result

(* Segment bitmaps: 8 chars x 8 bytes = 64 entries, flat *)
let bitmaps = [|
  0x1F; 0x1F; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;  (* 0: horiz top *)
  0x1F; 0x1F; 0x18; 0x18; 0x18; 0x18; 0x18; 0x18;  (* 1: corner LT *)
  0x18; 0x18; 0x18; 0x18; 0x18; 0x18; 0x18; 0x18;  (* 2: vert left *)
  0x18; 0x18; 0x18; 0x18; 0x18; 0x18; 0x1F; 0x1F;  (* 3: corner LB *)
  0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x1F; 0x1F;  (* 4: horiz bottom *)
  0x03; 0x03; 0x03; 0x03; 0x03; 0x03; 0x1F; 0x1F;  (* 5: corner RB *)
  0x03; 0x03; 0x03; 0x03; 0x03; 0x03; 0x03; 0x03;  (* 6: vert right *)
  0x1F; 0x1F; 0x03; 0x03; 0x03; 0x03; 0x03; 0x03;  (* 7: corner RT *)
|]

(* Digit patterns: 10 digits x 4 rows x 3 cols = 120 entries, flat.
   Values: 0-7 = custom char index, 8 = blank space *)
let digits = [|
  1;0;7; 2;8;6; 2;8;6; 3;4;5;   (* 0 *)
  8;8;7; 8;8;6; 8;8;6; 8;8;6;   (* 1 *)
  1;0;7; 8;8;6; 1;0;0; 3;4;4;   (* 2 *)
  1;0;7; 8;8;6; 8;0;7; 3;4;5;   (* 3 *)
  2;8;6; 3;4;5; 8;8;6; 8;8;6;   (* 4 *)
  1;0;0; 3;4;4; 8;8;6; 3;4;5;   (* 5 *)
  1;0;7; 2;8;8; 1;0;7; 3;4;5;   (* 6 *)
  1;0;7; 8;8;6; 8;8;6; 8;8;6;   (* 7 *)
  1;0;7; 3;4;5; 2;8;6; 3;4;5;   (* 8 *)
  1;0;7; 3;4;5; 8;8;6; 3;4;5;   (* 9 *)
|]

let load_custom_chars () =
  for i = 0 to 7 do
    Lcd.write_command (0x40 lor (i lsl 3));
    sleep_us 40;
    for j = 0 to 7 do
      Lcd.write_data bitmaps.(i * 8 + j);
      sleep_us 40
    done
  done;
  Lcd.move_to 0 0

let display_digit col digit =
  let base = digit * 12 in
  for row = 0 to 3 do
    Lcd.move_to col row;
    for c = 0 to 2 do
      let seg = digits.(base + row * 3 + c) in
      if seg = 8 then
        Lcd.write_data (Char.code ' ')
      else
        Lcd.write_data seg
    done
  done

let display_colon col visible =
  for row = 0 to 3 do
    Lcd.move_to col row;
    if visible && (row = 1 || row = 2) then
      Lcd.write_data 0xA5
    else
      Lcd.write_data (Char.code ' ')
  done

(* Display loop - runs on Core 1 via Domain.spawn.
   Uses only / and mod (no heap allocation) so Core 1 never triggers GC. *)
let display_loop colon () =
  while true do
    let bs = Atomic.get base_secs in
    let sm = Atomic.get sync_ms in
    let elapsed = (time_ms () - sm) / 1000 in
    let day_secs = (bs + elapsed) mod 86400 in
    let hours = day_secs / 3600 in
    let minutes = (day_secs mod 3600) / 60 in
    let seconds = day_secs mod 60 in
    display_digit  2 (hours / 10);
    display_digit  6 (hours mod 10);
    display_colon  9 !colon;
    display_digit 10 (minutes / 10);
    display_digit 14 (minutes mod 10);
    Lcd.move_to 18 3;
    Lcd.write_data (Char.code '0' + seconds / 10);
    Lcd.write_data (Char.code '0' + seconds mod 10);
    colon := not !colon;
    sleep_ms 1000
  done

let () =
  print_endline "=== OCaml Digital Clock ===";
  print_endline "  Core 0: NTP sync";
  print_endline "  Core 1: LCD display";
  print_endline "";

  let _ = cyw43_init () in

  (* Backlight *)
  pwm_init 22 1000 65535;

  (* Initialize LCD *)
  Lcd.init
    ~rs_pin:16 ~en_pin:17
    ~d4_pin:18 ~d5_pin:19 ~d6_pin:20 ~d7_pin:21
    ~lines:4 ~cols:20;
  load_custom_chars ();

  (* Show WiFi status on LCD *)
  Lcd.move_to 0 0;
  Lcd.print_string "Connecting WiFi...";
  Lcd.move_to 0 1;
  Lcd.print_string wifi_ssid;

  (* Connect WiFi *)
  Net.run (fun () ->
    print_endline "Connecting to WiFi...";
    Net.Wifi.connect ~ssid:wifi_ssid ~password:wifi_password ();
    let ip = Net.Wifi.get_ip () in
    print_string "IP: ";
    print_endline ip;
    Lcd.move_to 0 2;
    Lcd.print_string "IP: ";
    Lcd.print_string ip
  );
  sleep_ms 1000;
  Lcd.clear ();

  (* Pre-allocate display loop state on Core 0's heap *)
  let colon = ref true in

  (* Aggressively free memory before spawning second domain *)
  Gc.compact ();
  let _display = Domain.spawn (display_loop colon) in
  print_endline "Display running on Core 1";

  (* Core 0: NTP sync loop (first sync + periodic re-sync) *)
  while true do
    Gc.full_major ();
    Net.run (fun () ->
      match ntp_query () with
      | Some (h, m, s) ->
          Atomic.set base_secs (h * 3600 + m * 60 + s);
          Atomic.set sync_ms (time_ms ());
          print_string "NTP sync: ";
          print_int_02 h; print_string ":";
          print_int_02 m; print_string ":";
          print_int_02 s; print_endline ""
      | None ->
          print_endline "NTP failed"
    );
    sleep_ms resync_interval_ms
  done
