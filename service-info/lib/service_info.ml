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
  }

let service_info_item line =
  let matches =
    let pattern = "([a-zA-Z]+)[ \t]+([0-9]+)/([a-zA-Z]+)" in
    Re.exec (Re.Posix.compile_pat pattern) line
  in
  { service_name = Re.Group.get matches 1
  ; port = Int.of_string (Re.Group.get matches 2)
  ; protocol = Re.Group.get matches 3
  }


let service_info_to_string { service_name = sn; port = p; protocol = proto } =
  sprintf "%s %i/%s" sn p proto
