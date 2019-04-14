
open Lexer
open Data

let value = lex (object
        val mutable _index = -1
        val stuff = {|blah123_ _blah
                      &*&^ ?
                     *|} 
        method move_next = 
            if _index < String.length stuff - 1 then begin
                _index <- _index + 1
                ; true
                end
            else 
                false
        method current = stuff.[_index]  
        method index = _index
     end
     );;

let p = function
    | Number (x,_) -> "number"
    | Symbol (s,i) -> Printf.sprintf "symbol %s %d" s i
    | Op (o,i) -> Printf.sprintf "op %s %d" o i
    | _ -> "empty" ;;

List.iter (fun x -> Printf.printf "%s\n" (p x)) value


