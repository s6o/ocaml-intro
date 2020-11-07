open Mail_filter

let%test "trim expression 1" =
  trim_expr
    (Not (And [ Or [ Base "it's snowing"; Const true ]; Base "it's raining" ]))
  = Not (Base "it's raining")

let%test "trim expression 2" =
  trim_expr
    (Not
       (And
          [ Or [ Base "it's snowing"; Const true ]
          ; Not (Not (Base "it's raining"))
          ]))
  = Not (Not (Not (Base "it's raining")))
