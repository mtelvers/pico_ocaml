(* Generate curry, apply, and tuplify functions *)

(* Curry functions *)
let f2 a b = a + b
let f3 a b c = a + b + c
let f4 a b c d = a + b + c + d
let f5 a b c d e = a + b + c + d + e
let f6 a b c d e f = a + b + c + d + e + f
let f7 a b c d e f g = a + b + c + d + e + f + g
let f8 a b c d e f g h = a + b + c + d + e + f + g + h

(* Force curry generation *)
let _ = f2 1 2
let _ = f3 1 2 3
let _ = f4 1 2 3 4
let _ = f5 1 2 3 4 5
let _ = f6 1 2 3 4 5 6
let _ = f7 1 2 3 4 5 6 7
let _ = f8 1 2 3 4 5 6 7 8

(* Apply functions through higher-order *)
let apply2 f = f 1 2
let apply3 f = f 1 2 3
let apply4 f = f 1 2 3 4
let apply5 f = f 1 2 3 4 5
let apply6 f = f 1 2 3 4 5 6
let apply7 f = f 1 2 3 4 5 6 7
let apply8 f = f 1 2 3 4 5 6 7 8

let _ = apply2 f2
let _ = apply3 f3
let _ = apply4 f4
let _ = apply5 f5
let _ = apply6 f6
let _ = apply7 f7
let _ = apply8 f8

(* Tuplify functions - take tuple and return result *)
let tup2 (a, b) = a + b
let tup3 (a, b, c) = a + b + c
let tup4 (a, b, c, d) = a + b + c + d

let _ = tup2 (1, 2)
let _ = tup3 (1, 2, 3)
let _ = tup4 (1, 2, 3, 4)
