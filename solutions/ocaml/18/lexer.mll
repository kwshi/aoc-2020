let white = [' ']+
let int = ['0'-'9']+

rule read =
  parse
  | white { read lexbuf }
  | int { Parser.Int (int_of_string @@ Lexing.lexeme lexbuf) }
  | '(' { Parser.Paren_l }
  | ')' { Parser.Paren_r }
  | '+' { Parser.Add }
  | '*' { Parser.Mul }
  | eof { Parser.Eof }
