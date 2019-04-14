
open List
open Data
open Str

let is_op c = 
    match c with 
    | '+' | '*' | '-' | '/' | '^'  
    | '|' | '&' | '>' | '<' | '=' 
    | '.' | '#' | '@' | '!' | '%' 
    | '$' | '?' | '~' | '`' | ':' -> true
    | _ -> false

let lex_op input = 
    let start = input#index in
    let ret = Buffer.create 4 in
    Buffer.add_char ret input#current
    ; while input#move_next && is_op input#current do
        Buffer.add_char ret input#current
    done
    ; Op (Buffer.contents ret, start)

let lex (input : <current : char
                 ;index : int
                 ;move_next : bool
                 >) =
    let ret = ref [] in 
    while input#move_next do
        match input#current with
        | c when is_op c -> ret := lex_op input :: !ret
    done
    ; rev !ret


