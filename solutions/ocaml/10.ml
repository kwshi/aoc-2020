
let diffs nums = 
  List.map2 (-) nums 
  (0 :: List.(rev % tl % rev) nums)
  |> List.fold_left (fun (d1, d3) -> function
    | 1 -> (d1 + 1, d3)
    | 3 -> (d1, d3 + 1)
    | _ -> (d1, d3)
    ) (0, 0)
  |> fun (d1, d3) -> d1 * (d3 + 1)

let count =
  let rec go acc =
    function
    | [] -> List.hd acc |> snd
    | n :: nums -> 
        go 
        ( (n, List.fold_while (fun sum (m, c) ->
            if m < n - 3 
            then (sum, `Stop)
            else (c + sum, `Continue) 
            ) 0 acc
          ) :: acc
        ) nums
  in go [(0, 1)]

let () = 
  let nums = 
    IO.read_lines_l stdin
  |> List.map Int.of_string_exn
  |> List.sort Int.compare
  in
  Printf.printf "%d %d\n"
  (diffs nums)
  (count nums)
