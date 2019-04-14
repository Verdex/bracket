
type meta_data = int

type token = 
    | String of string * meta_data
    | Symbol of string * meta_data
    | Op of string * meta_data
    | Number of string * meta_data

