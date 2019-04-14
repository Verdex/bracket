
open List
open Data
open Str

let is_number c = 
    match c with
    | '0' .. '9' -> true
    | _ -> false

let is_number_or_dot c =
    match c with
    | '0' .. '9' -> true
    | '.' -> true
    | _ -> false

(* TODO add hex support *)
(* TODO add bin support *)
let lex_number input = 
    let start = input#index in
    let ret = Buffer.create 16 in
    Buffer.add_char ret input#current
    ; while input#move_next && is_number_or_dot input#current do
        Buffer.add_char ret input#current
    done
    ; Number (Buffer.contents ret, start)

let is_whitespace c = 
    match c with
    | '\t' | '\n' | '\r' | ' ' -> true
    | _ -> false

let is_symbol_start c = 
    match c with
    | 'a' .. 'z' | 'A' .. 'Z' | '_' -> true
    | _ -> false

let is_symbol c = 
    match c with
    | '0' .. '9' -> true
    | v when is_symbol_start v -> true
    | _ -> false

let lex_symbol input = 
    let start = input#index in
    let ret = Buffer.create 16 in
    Buffer.add_char ret input#current
    ; while input#move_next && is_symbol input#current do
        Buffer.add_char ret input#current
    done
    ; Symbol (Buffer.contents ret, start)

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

let is_line_comment input = ()

let lex (input : <current : char
                 ;index : int
                 ;move_next : bool
                 ;look_ahead : int -> char option
                 >) =
    let ret = ref [] in 
    while input#move_next do
        match input#current with
        | '(' -> ret := LParen input#index :: !ret 
        | ')' -> ret := RParen input#index :: !ret 
        | '{' -> ret := LCurl input#index :: !ret 
        | '}' -> ret := RCurl input#index :: !ret 
        | '[' -> ret := LSquare input#index :: !ret
        | ']' -> ret := RSquare input#index :: !ret
        | ',' -> ret := Comma input#index :: !ret 
        | ';' -> ret := Semi input#index :: !ret 
        | c when is_whitespace c -> ()
        | c when is_symbol_start c -> ret := lex_symbol input :: !ret 
        | c when is_number c -> ret := lex_number input :: !ret
        | c when is_op c -> ret := lex_op input :: !ret 
        | _ -> ()
    done
    ; rev !ret


