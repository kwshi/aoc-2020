IN: 02
USING: 
  io kernel splitting
  math math.order math.parser 
  sequences arrays prettyprint ;

: parse ( line -- m n c s )
  ": " split1
  [ " " split1 
    [ "-" split1 [ string>number ] bi@ ] dip
    first
  ] dip ;

: valid1 ( m n c s -- ? )
  swap [ = ] curry count
  -rot between? ;

: valid2 ( m n c s -- ? )
  [ swapd [ 1 - ] dip nth = ] 2curry
  bi@ xor ;

: bool>n ( ? -- n )
  [ 1 ] [ 0 ] if ;

0 0
[ parse 
  [ valid1 bool>n swap [ + ] dip ] 4keep
  valid2 bool>n +
] each-line . .
