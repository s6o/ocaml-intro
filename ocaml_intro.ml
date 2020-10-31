open Core_kernel

type running_sum =
  { mutable sum : float
  ; mutable sum_sq : float
  ; mutable samples : int
  }

let mean rsum = rsum.sum /. Float.of_int rsum.samples

let stdev rsum =
  Float.sqrt
    ( (rsum.sum_sq /. Float.of_int rsum.samples)
    -. ((rsum.sum /. Float.of_int rsum.samples) **. 2.) )


let create () = { sum = 0.; sum_sq = 0.; samples = 0 }

let update rsum x =
  rsum.samples <- rsum.samples + 1 ;
  rsum.sum <- rsum.sum +. x ;
  rsum.sum_sq <- rsum.sum_sq +. (x *. x)


let rsum = create ()

let () =
  List.iter [ 1.; 3.; 2.; -7.; 4.; 5. ] ~f:(fun x -> update rsum x) ;
  let result1 = mean rsum in
  let result2 = stdev rsum in
  Format.printf "Results %f %f" result1 result2
