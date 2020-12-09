IN: 08
USING: 
  io kernel combinators prettyprint locals
  sequences arrays splitting hash-sets.numbers sets
  math math.order math.parser math.ranges
  pair-rocket ;

: parse ( line -- cmd n )
  " " split1 string>number ;

:: run* ( prog alt seen acc ptr -- acc rep? )
  { [ ptr prog length >= ] => [ acc f ]
    [ ptr seen in? ] => [ acc t ]
    [ ptr seen adjoin
      ptr prog nth first2 swap ptr alt = 2array
      { [ dup first "acc" = ] =>
          [ drop [ prog alt seen acc ] dip + ptr 1 + run* ]
        [ dup { { "jmp" f } { "nop" t } } in? ] => 
          [ drop [ prog alt seen acc ptr ] dip + run* ]
        [ dup { { "nop" f } { "jmp" t } } in? ] => 
          [ 2drop prog alt seen acc ptr 1 + run* ]
      } cond
    ]
  } cond ;

: run ( prog alt -- rep? acc )
  NHS{ } clone 0 0 run** ;

lines [ parse 2array ] map 
[ -1 run drop . ]
[ dup length [0,b) 
  [ dupd run [ drop f ] when 
  ] map-find nipd drop .
]
bi
