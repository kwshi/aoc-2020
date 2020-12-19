let parse p s = p Lexer.read @@ Lexing.from_string s

let run ch =
  let rec go (s1, s2) =
    match IO.read_line ch with
  | None -> (s1, s2)
  | Some s -> 
    ( s1 + parse Parser.prog1 s
    , s2 + parse Parser.prog2 s
    ) |> go
  in go (0, 0)
    
let () = 
  let s1, s2 = run stdin in
  Printf.printf "%d %d\n" s1 s2
