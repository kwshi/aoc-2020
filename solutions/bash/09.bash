#!/bin/bash -eu
set -o pipefail

declare -ia nums
readarray -t nums

declare -ia sums
for (( i = 1; i < 25; ++i )); do
  for (( j = 0; j < i; ++j )); do
    (( s = nums[i] + nums[j] ))
    [[ -v sums[s] ]] || sums[s]=0
    (( ++sums[s] ))
  done
done

for (( i = 25; i < ${#nums[@]}; ++i )); do
  if [[ ! -v 'sums[nums[i]]' ]]; then (( bad = nums[i] )); break; fi

  (( j = i-25 )) || true
  for (( k = j+1; k < i; ++k )); do
    (( s = nums[j] + nums[k] ))
    (( --sums[s] )) || unset 'sums[s]'

    (( s = nums[k] + nums[i] ))
    [[ -v sums[s] ]] || sums[s]=0
    (( ++sums[s] ))
  done
done

echo "$bad"

i=0 j=0 acc=0
while (( j + 1 == i || acc != bad )); do
  if (( acc < bad )); then (( acc += nums[i], ++i ))
  else (( acc -= nums[j], ++j ))
  fi
done

min=$bad
max=0
for (( k = j; k < i; ++k )); do
  n=${nums[$k]}
  (( min += (n < min) * (n - min)
   , max += (n > max) * (n - max) 
   , 1
  ))
done
echo $(( min + max ))
