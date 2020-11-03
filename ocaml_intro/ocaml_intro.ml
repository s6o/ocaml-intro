open Base
open Stdio

let max_widths header rows =
  let lengths l = List.map ~f:String.length l in
  List.fold rows ~init:(lengths header) ~f:(fun acc row ->
      List.map2_exn ~f:Int.max acc (lengths row))


let render_border widths =
  let columns = List.map widths ~f:(fun w -> String.make (w + 2) '-') in
  "|" ^ String.concat ~sep:"+" columns ^ "|"


let col_pad s length = " " ^ s ^ String.make (length - String.length s + 1) ' '

let render_row row widths =
  let padded = List.map2_exn row widths ~f:col_pad in
  "|" ^ String.concat ~sep:"|" padded ^ "|"


let render_table header rows =
  let widths = max_widths header rows in
  String.concat
    ~sep:"\n"
    ( render_row header widths
    :: render_border widths
    :: List.map rows ~f:(fun row -> render_row row widths) )


let data =
  ( [ "language"; "architect"; "first release" ]
  , [ [ "Lisp"; "John McCarthy"; "1958" ]
    ; [ "C"; "Dennis Ritchie"; "1969" ]
    ; [ "ML"; "Robin Milner"; "1973" ]
    ; [ "OCaml"; "Xavier Leroy"; "1996" ]
    ] )


let () =
  let header, rows = data in
  render_table header rows |> printf "%s\n"
