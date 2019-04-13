
open Lexer
open Data

let value = lex (object
        val mutable x = true
        method move_next = 
            if x then (x <- false ; true)
            else false
        method current = '5'
     end
     );;

let p = function
    | Number (x,_) -> "blah"
    | _ -> "empty" ;;

List.iter (fun x -> Printf.printf "%s\n" (p x)) value


