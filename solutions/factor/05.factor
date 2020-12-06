IN: 05
USING: 
  io kernel prettyprint arrays sequences
  math math.order math.ranges math.parser
  pair-rocket splitting ;

: mid ( i j -- k )
  + -1 shift ;

: bisect ( seq -- i )
  [ length [ 0 1 ] dip shift ] keep
  [ [ [ mid ] keep ] [ dupd mid ] if
  ] each drop ;

: id ( s -- i )
  >array 7 cut
  [ [ CHAR: B = ] map bisect 3 shift ] 
  [ [ CHAR: R = ] map bisect ] 
  bi* + ;

: id-trick ( s -- i )
  { "F" => "0" "B" => "1" "L" => "0" "R" => "1" }
  [ first2 replace ] each bin> ;

: p1 ( ids -- max ) 
  0 [ max ] reduce ;

: p2 ( ids -- id )
  [ 1024 f <repetition> >array ] dip
  [ t swap rot [ set-nth ] keep ] each
  [ [ nth ] curry ] [ length 1 - ] bi [1,b)
  [ [ 1 + ] [ 1 - ] [ ] tri reach tri@ not and and 
  ] find 2nip ;

lines [ id-trick ] map [ p1 . ] [ drop ] bi
