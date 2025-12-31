(* Prime counting benchmark for dual-core Pico 2 W *)

external print_string : string -> unit = "pico_print_string"
external print_endline : string -> unit = "pico_print"
external print_int : int -> unit = "pico_print_int"
external time_ms : unit -> int = "ocaml_time_ms"

let is_prime n =
  if n < 2 then false
  else
    let rec check i =
      if i * i > n then true
      else if n mod i = 0 then false
      else check (i + 1)
    in
    check 2

let rec count_primes acc lo hi =
  if lo > hi then acc
  else count_primes (if is_prime lo then acc + 1 else acc) (lo + 1) hi

let () =
  print_endline "Prime Count Benchmark";
  print_endline "";

  let limit = 1_000_000 in

  (* Single-core test *)
  print_endline "=== Single-core ===";
  let t0 = time_ms () in
  let result1 = count_primes 0 2 limit in
  let t1 = time_ms () in
  let single_time = t1 - t0 in
  print_string "Result: ";
  print_int result1;
  print_string " primes in ";
  print_int single_time;
  print_endline " ms";

  (* Dual-core test *)
  print_endline "";
  print_endline "=== Dual-core ===";

  (* Split at 63% for balanced workload *)
  let split = (limit * 63) / 100 in
  let r1 = ref 0 in
  let r2 = ref 0 in

  let t2 = time_ms () in
  let d = Domain.spawn (fun () ->
    count_primes 0 2 split
  ) in

  r2 := count_primes 0 (split + 1) limit;
  r1 := Domain.join d;
  let t3 = time_ms () in
  let dual_time = t3 - t2 in

  let result2 = !r1 + !r2 in
  print_string "Result: ";
  print_int result2;
  print_string " primes in ";
  print_int dual_time;
  print_endline " ms";

  (* Summary *)
  print_endline "";
  print_endline "=== Summary ===";
  print_string "Single-core: ";
  print_int single_time;
  print_endline " ms";
  print_string "Dual-core:   ";
  print_int dual_time;
  print_endline " ms";
  print_string "Speedup:     ";
  print_int ((single_time * 100) / dual_time);
  print_endline "%";

  print_endline "";
  print_endline "Done!"
