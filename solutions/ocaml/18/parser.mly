%token <int> Int
%token Add
%token Mul
%token Paren_l
%token Paren_r
%token Eof

%start <int> prog1
%start <int> prog2
%%

let prog1 := prog(expr1)
let prog2 := prog(expr2)

let prog(e) := terminated(e, Eof)

let atom(e) :=
  | Int
  | delimited(Paren_l, e, Paren_r)

let expr1 :=
  | atom(expr1)
  | a = expr1; Add; b = atom(expr1); {a + b}
  | a = expr1; Mul; b = atom(expr1); {a * b}

let sum :=
  | atom(expr2)
  | a = sum; Add; b = atom(expr2); {a + b}

let expr2 :=
  | sum
  | a = expr2; Mul; b = sum; {a * b}
