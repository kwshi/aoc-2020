import sys
import functools as ft
import itertools as it
import operator as op
import collections as co

def bisect(steps):
    i, j = 0, 1 << len(steps)
    for step in steps:
        k = (i+j)>>1
        if step: i = k
        else: j = k
    return i

def seat_id(bpass):
    row = bisect([c == 'B' for c in bpass[:7]])
    seat = bisect([c == 'R' for c in bpass[7:]])
    return row * 8 + seat

def seat_id_trick(bpass):
    return int(bpass.replace('F', '0').replace('B', '1').replace('L', '0').replace('R', '1'), 2)

lines = [line.strip() for line in sys.stdin]

print(max(map(seat_id_trick, lines)))

filled = [False] * (1<<10)

for i in map(seat_id_trick, lines):
    filled[i] = True

for k in range(1, len(filled)-2):
    if filled[k-1] and filled[k+1] and not filled[k]:
        print(k)
        break
