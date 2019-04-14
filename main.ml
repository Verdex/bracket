
open Lexer
open Data

let value = lex (object
        val mutable x = true
        method move_next = 
            if x then (x <- false ; true)
            else false
        method current = '*'
        method index = 0
     end
     );;

let p = function
    | Number (x,_) -> "number"
    | Op (o,i) -> Printf.sprintf "op %s %d" o i
    | _ -> "empty" ;;

List.iter (fun x -> Printf.printf "%s\n" (p x)) value


