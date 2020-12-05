#!/bin/bash -eu

v1=0
v2=0

while IFS=' ' read -r nums char word
do
  i="${nums%-*}"
  j="${nums#*-}"
  c="${char%:}"

  rep="${word//[^"$char"]}"
  ct="${#rep}"
  (( v1 += i <= ct && ct <= j )) || true

  [[ "${word:i-1:1}" == "$c" ]] && ci=1 || ci=0
  [[ "${word:j-1:1}" == "$c" ]] && cj=1 || cj=0
  (( v2 += ci != cj )) || true
done

echo "$v1" "$v2"
