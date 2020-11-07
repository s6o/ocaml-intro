open Core

type 'a expr =
  | Base of 'a
  | Const of bool
  | And of 'a expr list
  | Or of 'a expr list
  | Not of 'a expr

type mail_field =
  | To
  | From
  | Cc
  | Date
  | Subject

type mail_predicate =
  { field : mail_field
  ; contains : string
  }

let pred_test field contains = Base { field; contains }

let and_ l =
  if List.exists l ~f:(function Const false -> true | _ -> false)
  then Const false
  else
    match List.filter l ~f:(function Const true -> false | _ -> true) with
    | [] ->
        Const true
    | [ x ] ->
        x
    | l ->
        And l


let or_ l =
  if List.exists l ~f:(function Const true -> true | _ -> false)
  then Const true
  else
    match List.filter l ~f:(function Const false -> false | _ -> true) with
    | [] ->
        Const false
    | [ x ] ->
        x
    | l ->
        Or l


let not_ = function
  | Const b ->
      Const (not b)
  | Not e ->
      e
  | (Base _ | And _ | Or _) as e ->
      Not e


let rec trim_expr = function
  | (Base _ | Const _) as x ->
      x
  | And l ->
      and_ (List.map ~f:trim_expr l)
  | Or l ->
      or_ (List.map ~f:trim_expr l)
  | Not e ->
      not_ (trim_expr e)
