IN: 05
USING: 
  arrays math math.order math.ranges
  io prettyprint kernel sequences
  locals ;

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

: p1 ( ids -- max ) 
  0 [ max ] reduce ;

: p2 ( ids -- id )
  [ 1024 f <repetition> >array ] dip
  [ t swap rot [ set-nth ] keep ] each
  [ [ nth ] curry ] [ length 1 - ] bi [1,b)
  [ [ 1 + ] [ 1 - ] [ ] tri reach tri@ not and and 
  ] find 2nip ;

lines [ id ] map [ p1 . ] [ p2 . ] bi
