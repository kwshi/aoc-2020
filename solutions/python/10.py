import itertools as it
import collections as co
import math
import operator as op
import functools as ft
import pprint as pp
import sys
import lib
import bisect as bs

nums = [*map(int, lib.lines())]
nums.sort()

diffs = [b - a for a, b in zip(nums, nums[1:])]
c = co.Counter(diffs)
c[min(diffs)] += 1
print((c[3] + 1) * c[1])

@ft.lru_cache(None)
def count(i=0, prev=0):
    n = nums[i]
    if n > prev + 3:
        return 0
    if i == len(nums)-1:
        return 1
    return count(i+1, prev=n) + count(i+1, prev)

def count_dp():
    cts = [0] * len(nums)

    for i, n in enumerate(nums):
        if n > 3:
            break
        cts[i] = 1

    for i, n in enumerate(nums):
        for j in range(i-1, -1, -1):
            if n - nums[j] > 3:
                break
            cts[i] += cts[j]

    return cts[-1]

print(count())
print(count_dp())
