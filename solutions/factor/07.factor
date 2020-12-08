IN: 07
USING: 
  kernel io sequences arrays graphs prettyprint deques vectors
  math.parser math assocs sets hash-sets locals search-deques 
  dlists strings splitting pair-rocket hashtables literals
  memoize ;

: parse-rule ( s -- rule )
  " bags contain " split1 
  dup "no other bags." = 
  [ drop { } ]
  [ "," split
    [ " " split1-last drop [ CHAR: \s = ] trim
      " " split1 swap string>number 2array
    ] map
  ] if 2array ;

:: dfs ( graph src -- seen )
  src 1vector :> front HS{ } :> seen
  [ front empty? ] 
  [ front pop graph at
    [ dup seen in? [ drop ] 
      [ [ seen adjoin ] [ front push ] bi ] if 
    ] each
  ] until seen ;

:: build-rdeps ( rules -- rdeps )
  H{ } :> rdeps rules
  [ first2 :> ( ctr parts ) 
    parts [ first ctr swap rdeps push-at ] each
  ] each rdeps ;

! look ma, shuffles only
: build-rdeps' ( rules -- rdeps )
  H{ } swap
  [ first2 [ first dupd reach push-at ] each drop
  ] each ;

MEMO: count ( deps src -- n )
  over at [ first2 [ dupd count 1 + ] dip * ] map-sum nip ;
  

lines [ empty? ] trim [ parse-rule ] map
[ build-rdeps' "shiny gold" dfs cardinality . ]
[ "shiny gold" count . ]
bi
