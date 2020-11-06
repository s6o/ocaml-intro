open Core

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
