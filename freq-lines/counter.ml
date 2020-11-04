open Base

type t = (string, int, String.comparator_witness) Map.t

let empty = Map.empty (module String)

let to_list t = Map.to_alist t

let touch t s =
  let count = match Map.find t s with None -> 0 | Some x -> x in
  Map.set t ~key:s ~data:(count + 1)


type median =
  | Median of (string * int)
  | Before_and_after of (string * int) * (string * int)

let median t =
  let sorted_string =
    List.sort (Map.to_alist t) ~compare:(fun (_, x) (_, y) ->
        Int.descending x y)
  in
  let len = List.length sorted_string in
  if len = 0 then failwith "median: empty frequency count" ;
  let nth n = List.nth_exn sorted_string n in
  if len % 2 = 1
  then Median (nth (len / 2))
  else Before_and_after (nth ((len / 2) - 1), nth (len / 2))
