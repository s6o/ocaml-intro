open Base
open Stdio

let rec read_and_accumulate accum =
  let line = In_channel.input_line In_channel.stdin in
  match line with
  | None ->
      accum
  | Some x ->
      read_and_accumulate (accum +. Float.of_string x)


(** Enter number on command line with enter and press Ctrl+D to calculate sum *)
let () = printf "Total: %F\n" (read_and_accumulate 0.)
