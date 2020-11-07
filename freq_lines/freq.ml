open Base
open Stdio

let build_counts () =
  In_channel.fold_lines In_channel.stdin ~init:Counter.empty ~f:Counter.touch


let () =
  let freqs = build_counts () in
  freqs
  |> Counter.to_list
  |> (fun lst ->
       match Counter.median freqs with
       | Median (l, c) ->
           (l ^ " | ~ Median ~ ", c) :: lst
       | Before_and_after ((bl, bc), (al, ac)) ->
           (bl ^ " | ~ Before ~ ", bc) :: (al ^ " | ~ After ~ ", ac) :: lst)
  |> List.sort ~compare:(fun (_, x) (_, y) -> Int.descending x y)
  |> (fun l -> List.take l 10)
  |> List.iter ~f:(fun (line, count) -> printf "%3d: %s\n" count line)
