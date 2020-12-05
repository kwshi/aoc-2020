
module S = Set.Make(Int)

let nums = 
  IO.read_lines_gen stdin
  |> List.of_gen
  |> List.map int_of_string

let set = S.of_list nums

let () = 
  let n = List.find (fun n -> S.mem (2020-n) set) nums in
  print_int (n * (2020-n))
  ; print_newline ()

let () =
  List.diagonal nums 
    |> List.find_map
    (fun (m, n) ->
      let k = 2020 - m - n in
      if S.mem k set then Some (m * n * k) else None
      )
    |> Option.get_exn
    |> print_int
    ; print_newline ()

