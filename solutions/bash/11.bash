#!/bin/bash -eu

readarray -t grid
rows=${#grid[@]}
cols=${#grid[0]}
declare -a flat

for ((i=0; i<rows; ++i)); do
  for ((j=0; j<cols; ++j)); do
    flat[i*cols+j]=${grid[i]:$j:1}
  done
done

function make_adj {
  adj=()
  for ((i=0; i<rows; ++i)); do
    for ((j=0; j<cols; ++j)); do
      if [[ ${flat[i*cols+j]} == '.' ]]; then continue; fi
      for d in '1,0' '1,1' '0,1' '-1,1'; do
        declare -i di=${d%,?} dj=${d#?,} ii=i jj=j
        while true; do
          ((ii+=di, jj+=dj, 1))
          if ((ii<0 || ii>=rows || jj<0 || jj>=cols )); then break; fi
          if [[ ${flat[ii*cols+jj]} != '.' ]]; then 
            (( adj[${#adj[@]}] = (i*cols+j)*rows*cols + (ii*cols+jj) ))
            break
          fi
          if (( ! $1 )); then break; fi
        done
      done
    done
  done
}

function evolve {
  change=0
  declare -ia counts
  for ((i=0; i<rows*cols; ++i)); do counts[i]=0; done
  for i in "${adj[@]}"; do
    declare -i j='i/(rows*cols)' k='i%(rows*cols)'
    if [[ ${line[j]} == '#' ]]; then (( ++counts[k] )); fi
    if [[ ${line[k]} == '#' ]]; then (( ++counts[j] )); fi
  done
  for ((i=0; i<rows*cols; ++i)); do
    if [[ ${line[i]} == '#' && ${counts[i]} -ge $1 ]]; then 
      line[i]='L'
      change=1
    elif [[ ${line[i]} == 'L' && ${counts[i]} -eq 0 ]]; then
      line[i]='#'
      change=1
    fi
  done
}

function stabilise {
  declare -a line=("${flat[@]}")
  declare -i change=1
  declare -ia adj
  make_adj "$1"
  while ((change)); do evolve "$2"; done
  final=${line[*]}
  occ=${final//[^#]/}
  echo ${#occ}
}

stabilise 0 4
stabilise 1 5
