module Dict = Map.Make(String)

type ecl =
  | Amb
  | Blu
  | Brn
  | Gry
  | Grn
  | Hzl
  | Oth

type t = {
  byr: int;
  iyr: int;
  eyr: int;
  hgt: [`Cm | `In] * int;
  hcl: int;
  ecl: ecl;
  pid: int;
  cid: string option;
}

let make byr iyr eyr hgt hcl ecl pid cid =
  {byr; iyr; eyr; hgt; hcl; ecl; pid; cid}

let dim s =
  let open Option.Infix in
  [`Cm, "cm"; `In, "in"]
      |> List.map (fun (u, suf) -> String.chop_suffix ~suf s 
      >>= Int.of_string
      >|= Pair.make u
      )
      |> Option.choice

let hex s =
  let open Option.Infix in
  String.chop_prefix ~pre:"#" s >|= (^) "0x" >>= Int.of_string 

let ecl = [
  "amb", Amb;
  "blu", Blu;
  "brn", Brn;
  "gry", Gry;
  "grn", Grn;
  "hzl", Hzl;
  "oth", Oth;
]

let ecl_d = Dict.of_list ecl

let enum dict s = Dict.get s dict

let len n s = if Int.equal (String.length s) n then Some s else None

let parser =
  let open Angstrom in
  (Pair.make 
  <$> take_till (Char.equal ':') <* char ':' 
  <*> take_till (function ' ' | '\n' -> true | _ -> false)
  )
      |> sep_by (char ' ')
      >>| (Dict.of_list %> fun dict ->
        let open Option.Infix in
        let key k = Dict.get k dict in
        let int k = key k >>= Int.of_string in
        make <$> int "byr" <*> int "iyr" <*> int "eyr" 
    <*> (key "hgt" >>= dim)
    <*> (key "hcl" >>= hex)
    <*> (key "ecl" >>= enum ecl_d)
    <*> (key "pid" >>= len 9 >>= Int.of_string)
    <*> (key "cid" |> Option.pure)
    )

