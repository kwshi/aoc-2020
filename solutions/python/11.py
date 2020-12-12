import functools as ft
import collections as co
import itertools as it
import pprint as pp
import operator as op
import sys
import math

code = {'#': 2, 'L': 1, '.': 0}
grid = [[code[c] for c in row.strip()] for row in sys.stdin]
rows = len(grid)
cols = len(grid[0])
flat = [c for row in grid for c in row]
ser = lambda i, j: i * cols + j

def adj(grid, move: bool):
    for i, row in enumerate(grid):
        for j, c in enumerate(row):
            if not c: continue
            for di, dj in [(0, 1), (1, 0), (1, 1), (1, -1)]:
                ii, jj = i + di, j + dj
                while 0 <= ii < len(grid) and 0 <= jj < len(row):
                    if grid[ii][jj]:
                        yield (ser(i, j), ser(ii, jj))
                        break
                    if not move:
                        break
                    ii += di
                    jj += dj

def evolve(line, adj, thres):
    counts = [0] * len(line)
    for k, l in adj:
        counts[k] += int(line[l] == 2)
        counts[l] += int(line[k] == 2)
    new = [c + int(c == 1 and not n) - int(c == 2 and n >= thres) for k, (c, n) in enumerate(zip(line, counts))]
    return new

def until_stable(line, adj, thres):
    while True:
        new = evolve(line, adj, thres)
        if new == line:
            return new
        line = new

print(until_stable(flat, [*adj(grid, False)], 4).count(2))
print(until_stable(flat, [*adj(grid, True)], 5).count(2))

