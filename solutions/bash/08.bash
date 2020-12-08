#!/bin/bash -eu
set -o pipefail

readarray -t prog

function run {
  acc=0 ptr=0 repeat=0
  declare -A seen
  while [[ $ptr -lt ${#prog[@]} ]]; do
    if [[ -v seen[$ptr] ]]; then repeat=1; return; fi
    seen[$ptr]=
    line=${prog[$ptr]}

    read -r cmd n <<< "$line"
    [[ $1 -eq $ptr ]] && swap=1 || swap=0
    case $cmd:$swap in
      acc:?) (( acc += n )) || true; (( ++ptr )) || true;;
      jmp:0|nop:1) (( ptr += n )) || true;;
      nop:0|jmp:1) (( ++ptr )) || true;;
    esac
  done
}

run -1; echo "$acc"

for (( ch = 0; ch < ${#prog[@]}; ++ch )); do
  run "$ch"
  if (( ! repeat )); then
    echo "$acc"
    break
  fi
done
