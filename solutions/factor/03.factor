IN: 03
USING: kernel arrays io locals math prettyprint sequences ;

:: traverse ( di dj lines -- n )
  0 0 0
  [ over lines length >= ]
  [ over lines nth dupd [ length mod ] keep nth
    CHAR: # = [ 1 ] [ 0 ] if -rot [ + ] 2dip
    [ di + ] dip dj +
  ] until 2drop ;

lines >array

1 3 pick traverse .

{ { 1 1 } { 1 3 } { 1 5 } { 1 7 } { 2 1 } } 
[ first2 pick traverse ] map product .

drop
