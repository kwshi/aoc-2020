IN: 06
USING: io kernel sets sequences splitting prettyprint ;

lines [ empty? ] trim-slice { "" } split
[ combine ] [ intersection ] 
[ [ length ] compose [ map-sum . ] curry ] bi@ bi
