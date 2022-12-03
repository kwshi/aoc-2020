import itertools as it
import collections as co
import functools as ft
import pprint as pp
import heapq as hq
import operator as op
import sys
import math

nums = [*map(int, '459672813')]
#nums = [3, 8, 9, 1, 2, 5, 4, 6, 7]
pos = 0

def get(i):
    return nums[i % len(nums)]

def move():
    global pos
    global nums
    curr = get(pos)
    x = get(pos+1)
    y = get(pos+2)
    z = get(pos+3)
    dest = get(pos) - 1
    if dest == 0:
        dest = max(nums)
    while dest in (x, y, z):
        dest -= 1
        if dest <= 0:
            dest = max(nums)
    print('dest', dest)

    nums = [*nums[:pos+1], *nums[pos+4:]] if pos+4 <= len(nums) else nums[(pos+4)%len(nums):pos+1]
    i = nums.index(dest)
    nums = [*nums[:i+1], x, y, z, *nums[i+1:]]
    pos = nums.index(curr) + 1
    pos %= len(nums)

for _ in range(100):
    move()
    print(nums, pos)

#for _ in range(100):
#    move()
#
#print(nums)
