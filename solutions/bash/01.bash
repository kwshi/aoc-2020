#!/bin/bash -eu

readarray -t nums
declare -A exists

for n in "${nums[@]}"
do exists["$n"]=_
done

for n in "${nums[@]}"
do
  k="$((2020 - n))"
  if [ -n "${exists["$k"]+_}" ]
  then 
    echo "$((n * k))"
    break
  fi
done

for ((i=0; i<${#nums[@]}; ++i))
do
  m="${nums["$i"]}"
  for ((j=i+1; j<${#nums[@]}; ++j))
  do
    n="${nums["$j"]}"
    k="$((2020 - m - n))"
    if [ -n "${exists["$k"]+_}" ]
    then
      echo "$((m * n * k))"
      exit
    fi
  done
done
