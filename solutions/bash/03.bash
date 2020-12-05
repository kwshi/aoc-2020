#!/bin/bash -eu

readarray -t grid

function traverse {
  local trees=0
  local j=0
  for (( i=0; i<${#grid[@]}; i+=$1 ))
  do
    local line=${grid[$i]}
    if [[ ${line:$((j % ${#line})):1} == '#' ]]
    then (( ++trees )) || true
    fi
    (( j += "$2" )) || true
  done
  echo "$trees"
}

traverse 1 3

echo $((
  $(traverse 1 1)
  * $(traverse 1 3)
  * $(traverse 1 5)
  * $(traverse 1 7)
  * $(traverse 2 1)
))
