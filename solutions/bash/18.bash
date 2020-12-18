#!/bin/bash -eu
set -o pipefail

declare str
declare -i ret i sum1=0 sum2=0

function atom {
  declare c=${str:$i:1}
  if [[ $c == '(' ]]; then i+=1; "$1"; i+=1
  else ret=$c i+=1
  fi
}

function expr1 {
  declare o
  declare -i a
  atom expr1; a=$ret
  while [[ $i -ne ${#str} && ${str:$i:1} != ')' ]]; do
    o=${str:$i:1} i+=1
    atom expr1
    case $o in
      '+') ((a+=ret));;
      '*') ((a*=ret));;
    esac
  done
  ret=$a
}

function expr2 {
  declare o
  declare -i as=0 ap=1
  atom expr2; as=$ret
  while [[ $i -ne ${#str} && ${str:$i:1} != ')' ]]; do
    o=${str:$i:1} i+=1
    atom expr2
    case $o in
      '+') as+=ret;;
      '*') ((ap*=as)); as=ret;;
    esac
  done
  ret=$ap*$as
}

readarray -t lines
for line in "${lines[@]}"; do
  str=${line// }
  i=0; expr1; sum1+=ret
  i=0; expr2; sum2+=ret
done

echo "$sum1" "$sum2"
