let space =
  Angstrom.skip_while @@ Char.equal ' '

let int =
  let open Angstrom in
  space 
  *> take_while1 (function '0'..'9' -> true | _ -> false)
  >>| int_of_string

let atom e =
  let open Angstrom in
  int <|> (space *> char '(' *> e <* space <* char ')')

let expr1 =
  let open Angstrom in
  let op = space *> 
    ((char '*' >>| Fun.const `Mul) <|> (char '+' >>| Fun.const `Add))
  in
  fix (fun e ->
    let a = atom e in 
    (List.fold_left (fun acc (op, n) ->
      (match op with `Add -> (+) | `Mul -> ( * )) acc n
    )) <$> a <*> many (Pair.make <$> op <*> a) <* space
  )

let expr2 =
  let open Angstrom in
  fix (fun e ->
    let a = atom e in
    let sum = List.fold_left (+) <$> a <*> many (space *> char '+' *> a) in
    List.fold_left ( * ) <$> sum <*> many (space *> char '*' *> sum)
  )

let parse p = Angstrom.parse_string ~consume:All p %> Result.get_exn

let run ch =
  let rec go (s1, s2) =
    match IO.read_line ch with
    | None -> (s1, s2)
    | Some s -> go (s1 + parse expr1 s, s2 + parse expr2 s)
  in go (0, 0)

let () =
  let s1, s2 = run stdin in
  Printf.printf "%d %d\n" s1 s2
