(** t.buckets structure
[|
  [(k, v), .., (k, v)],
  [(k, v), .., (k, v)],
..
  [(k, v), .., (k, v)]
|]
**)
open Base

type ('a, 'b) t =
  { mutable length : int
  ; buckets : ('a * 'b) list array
  ; hash : 'a -> int
  ; equal : 'a -> 'a -> bool
  }

let num_buckets = 17

let hash_bucket t key = t.hash key % num_buckets

let create ~hash ~equal =
  { length = 0; buckets = Array.create ~len:num_buckets []; hash; equal }


let length t = t.length

let find t key =
  List.find_map
    t.buckets.(hash_bucket t key)
    ~f:(fun (k, v) -> if t.equal k key then Some v else None)


let iter t ~f =
  for i = 0 to Array.length t.buckets - 1 do
    List.iter t.buckets.(i) ~f:(fun (key, value) -> f ~key ~value)
  done


let bucket_has_key t i key =
  List.exists t.buckets.(i) ~f:(fun (k, _) -> t.equal k key)


let add t ~key ~value =
  let i = hash_bucket t key in
  let replace = bucket_has_key t i key in
  let filtered_bukcet =
    if replace
    then List.filter t.buckets.(i) ~f:(fun (k, _) -> not (t.equal k key))
    else t.buckets.(i)
  in
  t.buckets.(i) <- (key, value) :: filtered_bukcet ;
  if not replace then t.length <- t.length + 1


let remove t key =
  let i = hash_bucket t key in
  if bucket_has_key t i key
  then (
    let filtered_bukcet =
      List.filter t.buckets.(i) ~f:(fun (k, _) -> not (t.equal k key))
    in
    t.buckets.(i) <- filtered_bukcet ;
    t.length <- t.length - 1 )
