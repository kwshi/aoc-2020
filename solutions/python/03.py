import sys
import functools as ft
import operator as op
import itertools as it

lines = [line.strip() for line in sys.stdin]

def check(di, dj):
    i, j = 0, 0
    ct = 0
    while i < len(lines):
        line = lines[i]
        ct += int(line[j % len(line)] == '#')
        i += di
        j += dj
    return ct

print(check(1, 3))
print(ft.reduce(op.mul, it.starmap(check, [(1, 1), (1, 3), (1, 5), (1, 7), (2, 1)])))

