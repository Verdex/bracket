
type meta_data = ()

type token = 
    | String of string * meta_data
    | Symbol of string * meta_data
    | Op of string * meta_data
    | Number of float * meta_data

