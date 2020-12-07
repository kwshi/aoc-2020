IN: 01
USING: io kernel math math.parser 
  arrays sequences sets hash-sets
  prettyprint ;

lines [ string>number ] map [ >hash-set ] keep
[ [ [ 2020 swap - over [ in? ] keepd ] keep * f ?
  ] map-find drop .
]
[ dup 
  [ [ 2020 swap - swap - over [ in? ] keepd ] 2keep * * f ?
  ] cartesian-map concat [ ] map-find nip .
]
bi drop
