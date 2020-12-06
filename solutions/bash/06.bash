#!/bin/bash -e

total_any=0
total_all=0

function init {
  unset all any
  declare -gA all any

  for c in {a..z}
  do all[$c]=
  done
}

init
while read -r line
do
  if [[ -z $line ]]
  then 
    (( total_any += ${#any[@]} )) || true
    (( total_all += ${#all[@]} )) || true
    init
    continue
  fi

  for (( i = 0; i < ${#line}; ++i ))
  do any[${line:$i:1}]=
  done

  for c in "${!all[@]}"
  do
    if [[ -z ${line//[^$c]} ]] 
    then unset "all[$c]"
    fi
  done
done

echo "$total_any $total_all"
