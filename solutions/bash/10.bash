#!/bin/bash -eu
set -o pipefail

readarray -t nums < <(sort -n)

declare -ia diffs
prev=0
for n in "${nums[@]}"; do
  (( diff = n-prev ))
  [[ -v diffs[diff] ]] || diffs[diff]=0
  (( diffs[diff] += 1 ))
  prev=$n
done
echo $(( (diffs[3] + 1) * diffs[1] ))

declare -a cts
for (( i = 0; i < 3; ++i )); do
  if (( nums[i] > 3 )); then break; fi
  (( cts[i] = 1 ))
done
for (( i = 1; i < ${#nums[@]}; ++i )); do
  n=${nums[i]}
  [[ -v cts[i] ]] || cts[i]=0
  for (( j = i-1; j >= 0; --j )); do
    if (( n - nums[j] > 3 )); then break; fi
    (( cts[i] += cts[j] ))
  done
done

echo $(( cts[${#nums[@]} - 1] ))
