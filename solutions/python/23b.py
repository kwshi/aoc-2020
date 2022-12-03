import itertools as it
import collections as co
import functools as ft
import pprint as pp
import heapq as hq
import operator as op
import sys
import math

pattern = [4, 5, 9, 6, 7, 2, 8, 1, 3]
# pattern = [3, 8, 9, 1, 2, 5, 4, 6, 7]

head = [pattern[0], None, None]
prev = head
for n in it.chain(pattern[1:], range(max(pattern)+1, 1000000+1)):
    node = [n, prev, None]
    prev[2] = node
    prev = node
head[1] = prev
prev[2] = head

nodes = {}
curr = head
for _ in range(1000000):
    nodes[curr[0]] = curr
    curr = curr[2]

def show():
    curr = head
    for _ in range(1000000):
        print(curr[0])
        curr = curr[2]

for i in range(10000000):
    pickl = curr[2]
    pickr = pickl[2][2]
    picked = {pickl[0], pickl[2][0], pickr[0]}
    curr[2] = pickr[2]
    curr[2][1] = curr
    destv = (curr[0] - 1) % 1000000
    if destv == 0: destv = 1000000
    while destv in picked:
        destv = (destv - 1) % 1000000
        if destv == 0: destv = 1000000
    dest = nodes[destv]
    pickr[2] = dest[2]
    pickr[2][1] = pickr
    dest[2] = pickl
    pickl[1] = dest
    curr = curr[2]

print(nodes[1][2][0], nodes[1][2][2][0])



