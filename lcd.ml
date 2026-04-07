(* HD44780 LCD driver in OCaml for Pico 2 W *)
(* 4-bit mode GPIO interface - only GPIO/timing primitives are in C *)

external gpio_init : int -> unit = "ocaml_gpio_init"
external gpio_set_dir_out : int -> unit = "ocaml_gpio_set_dir_out"
external gpio_put : int -> bool -> unit = "ocaml_gpio_put"
external sleep_us : int -> unit = "ocaml_sleep_us"
external sleep_ms : int -> unit = "ocaml_sleep_ms"

type t = {
  rs : int; en : int;
  d4 : int; d5 : int; d6 : int; d7 : int;
  columns : int;
}

(* Low-level LCD protocol *)

let pulse_enable t =
  gpio_put t.en false;
  sleep_us 1;
  gpio_put t.en true;
  sleep_us 1;
  gpio_put t.en false;
  sleep_us 100

let write_4bits t nibble =
  gpio_put t.d7 (nibble land 8 <> 0);
  gpio_put t.d6 (nibble land 4 <> 0);
  gpio_put t.d5 (nibble land 2 <> 0);
  gpio_put t.d4 (nibble land 1 <> 0);
  pulse_enable t

let write_8bits t value =
  write_4bits t (value lsr 4);
  write_4bits t value

let write_command t cmd =
  gpio_put t.rs false;
  write_8bits t cmd;
  if cmd <= 3 then sleep_ms 5

let write_data t data =
  gpio_put t.rs true;
  write_8bits t data

(* Public API *)

let init ~rs_pin ~en_pin ~d4_pin ~d5_pin ~d6_pin ~d7_pin ~lines ~cols =
  let init_pin pin =
    gpio_init pin; gpio_set_dir_out pin; gpio_put pin false
  in
  init_pin rs_pin; init_pin en_pin;
  init_pin d4_pin; init_pin d5_pin; init_pin d6_pin; init_pin d7_pin;
  let t = { rs = rs_pin; en = en_pin;
            d4 = d4_pin; d5 = d5_pin; d6 = d6_pin; d7 = d7_pin;
            columns = cols } in
  (* HD44780 init sequence *)
  sleep_ms 20;
  write_4bits t 0x03; sleep_ms 5;
  write_4bits t 0x03; sleep_ms 1;
  write_4bits t 0x03; sleep_ms 1;
  write_4bits t 0x02; sleep_ms 1;
  (* Function set: 4-bit, multi-line, 5x8 font *)
  write_command t (0x20 lor (if lines > 1 then 0x08 else 0x00));
  write_command t 0x08;          (* Display off *)
  write_command t 0x01;          (* Clear *)
  sleep_ms 5;
  write_command t 0x02;          (* Home *)
  sleep_ms 5;
  write_command t 0x06;          (* Entry mode: increment, no shift *)
  write_command t 0x0C;          (* Display on, cursor off *)
  t

let clear t =
  write_command t 0x01;
  sleep_ms 5;
  write_command t 0x02;
  sleep_ms 5

let move_to t col row =
  let addr = col land 0x3f in
  let addr = if row land 1 <> 0 then addr + 0x40 else addr in
  let addr = if row land 2 <> 0 then addr + t.columns else addr in
  write_command t (0x80 lor addr)

let print_string t s =
  String.iter (fun c -> write_data t (Char.code c)) s
