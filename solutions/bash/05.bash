#!/bin/bash -eu

min=1024
max=0
declare -a filled
while read -r line
do
  br=${line//[BR]/1}
  id=$(( 2#${br//[FL]/0} ))

  min=$(( id < min ? id : min ))
  max=$(( id > max ? id : max ))

  filled[$id]=_
done

echo "$max"

for (( i = min; i <= max; ++i )) 
do
  if [[ -z ${filled[i]+_} ]]
  then 
    echo "$i"
    break
  fi
done
