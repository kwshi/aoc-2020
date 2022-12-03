import itertools as it
import collections as co
import functools as ft
import pprint as pp
import operator as op
import sys
import math

moves = sys.stdin.read().strip().split('\n')

x = 0
y = 0
dx = 10
dy = 1

for move in moves:
    d = move[0]
    n = int(move[1:])
    if d == 'F':
        x += dx * n
        y += dy * n
    elif d == 'N':
        dy += n
    elif d == 'S':
        dy -= n
    elif d == 'E':
        dx += n
    elif d == 'W':
        dx -= n
    elif d == 'L':
        k = n//90
        if k > 0:
            for _ in range(k): dy, dx = dx, -dy
        else: 
            for _ in range(-k): dy, dx = -dx, dy
    elif d == 'R':
        k = n//90
        if k > 0: 
            for _ in range(k): dy, dx = -dx, dy
        else: 
            for _ in range(-k): dy, dx = dx, -dy
    print(x, y)

print(abs(x) + abs(y))
