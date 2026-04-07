(* Digital clock on 20x4 HD44780 LCD *)
(* Dual-core: Domain 1 updates display, Domain 0 handles NTP sync *)

external print_endline : string -> unit = "pico_print"
external print_string : string -> unit = "pico_print_string"
external print_int : int -> unit = "pico_print_int"
external sleep_ms : int -> unit = "ocaml_sleep_ms"
external time_ms : unit -> int = "ocaml_time_ms"
external cyw43_init : unit -> int = "ocaml_cyw43_init"
external pwm_init : int -> int -> int -> unit = "ocaml_pwm_init"
external pwm_set_duty : int -> int -> unit = "ocaml_pwm_set_duty"
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

(* NTP query using raw UDP calls - no effect handlers, minimal allocation *)
let ntp_query () =
  let sock_id = Netif.udp_create () in
  if sock_id < 0 then None
  else begin
    let _ = Netif.udp_bind sock_id 0 in
    let result =
      try
        let packet = Bytes.make 48 '\000' in
        Bytes.set packet 0 (Char.chr 0x1B);
        let ip = Netif.dns_resolve "pool.ntp.org" in
        if ip = 0 then None
        else begin
          let _ = Netif.udp_sendto sock_id ip 123 packet 48 in
          Netif.service_network ();
          let buf = Bytes.make 48 '\000' in
          let rec recv_loop timeout =
            Netif.service_network ();
            let n = Netif.udp_recvfrom sock_id buf in
            if n > 0 then true
            else if timeout < 1000 then begin
              sleep_ms 10;
              recv_loop (timeout + 1)
            end else false
          in
          if recv_loop 0 then begin
            let b0 = Char.code (Bytes.get buf 40) in
            let b1 = Char.code (Bytes.get buf 41) in
            let b2 = Char.code (Bytes.get buf 42) in
            let b3 = Char.code (Bytes.get buf 43) in
            let raw = b0 * 15616 + b1 * 65536 + b2 * 256 + b3 in
            let secs_of_day = raw mod 86400 in
            let secs_wrapped = (secs_of_day + utc_offset_hours * 3600) mod 86400 in
            Some (secs_wrapped / 3600, (secs_wrapped mod 3600) / 60, secs_wrapped mod 60)
          end else None
        end
      with _ -> None
    in
    Netif.udp_close sock_id;
    result
  end

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

let load_custom_chars lcd =
  for i = 0 to 7 do
    Lcd.write_command lcd (0x40 lor (i lsl 3));
    sleep_us 40;
    for j = 0 to 7 do
      Lcd.write_data lcd bitmaps.(i * 8 + j);
      sleep_us 40
    done
  done;
  Lcd.move_to lcd 0 0

let display_digit lcd col digit =
  let base = digit * 12 in
  for row = 0 to 3 do
    Lcd.move_to lcd col row;
    for c = 0 to 2 do
      let seg = digits.(base + row * 3 + c) in
      if seg = 8 then
        Lcd.write_data lcd (Char.code ' ')
      else
        Lcd.write_data lcd seg
    done
  done

let display_colon lcd col visible =
  for row = 0 to 3 do
    Lcd.move_to lcd col row;
    if visible && (row = 1 || row = 2) then
      Lcd.write_data lcd 0xA5
    else
      Lcd.write_data lcd (Char.code ' ')
  done

(* Backlight brightness based on time of day.
   Gradual transition: +16/sec from 6am-7am, -16/sec from 9pm-10pm *)
let backlight_of_time day_secs =
  let min_bright = 7935 in   (* ~12% *)
  let max_bright = 65535 in
  if day_secs < 21600 then min_bright              (* midnight-6am *)
  else if day_secs < 25200 then                     (* 6am-7am: brighten *)
    min_bright + (day_secs - 21600) * 16
  else if day_secs < 75600 then max_bright          (* 7am-9pm *)
  else if day_secs < 79200 then                     (* 9pm-10pm: dim *)
    max_bright - (day_secs - 75600) * 16
  else min_bright                                    (* 10pm-midnight *)

(* Display loop - runs on Core 1 via Domain.spawn.
   Tail-recursive with bool parameter: no refs, no allocation. *)
let rec display_loop lcd colon =
  let bs = Atomic.get base_secs in
  let sm = Atomic.get sync_ms in
  let elapsed = (time_ms () - sm) / 1000 in
  let day_secs = (bs + elapsed) mod 86400 in
  pwm_set_duty 27 (backlight_of_time day_secs);
  let hours = day_secs / 3600 in
  let minutes = (day_secs mod 3600) / 60 in
  let seconds = day_secs mod 60 in
  display_digit lcd  2 (hours / 10);
  display_digit lcd  6 (hours mod 10);
  display_colon lcd  9 colon;
  display_digit lcd 10 (minutes / 10);
  display_digit lcd 14 (minutes mod 10);
  Lcd.move_to lcd 18 3;
  Lcd.write_data lcd (Char.code '0' + seconds / 10);
  Lcd.write_data lcd (Char.code '0' + seconds mod 10);
  sleep_ms 1000;
  display_loop lcd (not colon)

let () =
  print_endline "=== OCaml Digital Clock ===";
  print_endline "  Core 0: NTP sync";
  print_endline "  Core 1: LCD display";
  print_endline "";

  let _ = cyw43_init () in

  (* Backlight on GPIO 27 - avoids PWM slice conflict with CYW43 on GPIO 23 *)
  pwm_init 27 1000 65535;

  (* Initialize LCD *)
  let lcd = Lcd.init
    ~rs_pin:16 ~en_pin:17
    ~d4_pin:18 ~d5_pin:19 ~d6_pin:20 ~d7_pin:21
    ~lines:4 ~cols:20 in
  load_custom_chars lcd;

  (* Show WiFi status on LCD *)
  Lcd.move_to lcd 0 0;
  Lcd.print_string lcd "Connecting WiFi...";
  Lcd.move_to lcd 0 1;
  Lcd.print_string lcd wifi_ssid;

  (* Connect WiFi *)
  print_endline "Connecting to WiFi...";
  let _ = Netif.wifi_connect wifi_ssid wifi_password 30000 in
  let ip = Netif.wifi_get_ip () in
  let ip_str = Netif.ip_to_string ip in
  print_string "IP: ";
  print_endline ip_str;
  Lcd.move_to lcd 0 2;
  Lcd.print_string lcd "IP: ";
  Lcd.print_string lcd ip_str;
  sleep_ms 1000;
  Lcd.clear lcd;

  Gc.compact ();
  let _display = Domain.spawn (fun () -> display_loop lcd true) in
  print_endline "Display running on Core 1";

  (* Core 0: NTP sync loop (first sync + periodic re-sync) *)
  while true do
    begin match ntp_query () with
    | Some (h, m, s) ->
        Atomic.set base_secs (h * 3600 + m * 60 + s);
        Atomic.set sync_ms (time_ms ());
        print_string "NTP sync: ";
        print_int_02 h; print_string ":";
        print_int_02 m; print_string ":";
        print_int_02 s; print_endline ""
    | None ->
        print_endline "NTP failed"
    end;
    (* Keep polling network during wait to maintain WiFi connection *)
    for _ = 1 to resync_interval_ms / 100 do
      Netif.service_network ();
      sleep_ms 100
    done
  done
