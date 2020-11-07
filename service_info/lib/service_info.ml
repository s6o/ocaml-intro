open Core

type 'a with_line_number =
  { item : 'a
  ; number : int
  }

let parse_lines file_contents ~f:parse =
  let lines = file_contents |> String.split ~on:'\n' in
  List.mapi lines ~f:(fun line_num line ->
      { item = parse line; number = line_num + 1 })


type service_info =
  { service_name : string
  ; port : int
  ; protocol : string
  ; comment : string option
  }

let service_info_item line =
  let header, comment =
    match String.rsplit2 line ~on:'#' with
    | None ->
        (line, None)
    | Some (h, c) ->
        (h, Some c)
  in
  let matches =
    let pattern = "([a-zA-Z]+)[ \t]+([0-9]+)/([a-zA-Z]+)" in
    Re.exec (Re.Posix.compile_pat pattern) header
  in
  { service_name = Re.Group.get matches 1
  ; port = Int.of_string (Re.Group.get matches 2)
  ; protocol = Re.Group.get matches 3
  ; comment
  }


let service_info_to_string { service_name; port; protocol; comment } =
  let base = sprintf "%s %i/%s" service_name port protocol in
  match comment with None -> base | Some c -> base ^ "\t#" ^ c
