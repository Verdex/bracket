
open Data

let lex (input : <current : char
                 ;move_next : bool
                 >) =
    let ret = ref [] in 
    while input#move_next do
        ret := List.cons (Number (5.0, ())) !ret 
    done
    ; !ret





