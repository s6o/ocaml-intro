open Base

(** A collection of strin frequency counts. *)
type t

val empty : t
(** The empty set of frequency counts. *)

val touch : t -> string -> t
(** Bump the frequency count for the given string. *)

val to_list : t -> (string * int) list
(** Converts the set of frequency counts to an association list.  A string shows
    up at most once, and the counts are >= 1. *)
