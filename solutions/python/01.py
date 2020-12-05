import sys
import itertools as it

nums = {*map(int, sys.stdin)}

for n in nums:
    m = 2020-n
    if m in nums:
        print(n*m)
        break

for m, n in it.combinations(nums, 2):
    k = 2020-m-n
    if k in nums:
        print(m*n*k)
        break
