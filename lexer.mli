
open Data

val lex : <current : char
          ;index : int
          ;move_next : bool
          ;look_ahead : int -> char option> -> token list

