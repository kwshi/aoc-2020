import math
import pprint as pp
import sys
import operator as op
import collections as co
import itertools as it
import functools as ft

init = {(i, j) for i, row in enumerate(sys.stdin) for j, c in enumerate(row) if c == '#'}

def neighbors(pos):
    for dp in it.product([-1, 0, 1], repeat=len(pos)):
        p = (*it.starmap(op.add, zip(dp, pos)),)
        if p != pos: yield p

def evolve(space, dims):
    counts = co.defaultdict(int)
    for pos in space:
        counts[pos] # initialize to 0
        for p in neighbors(pos):
            counts[p] += 1
    for pos, c in counts.items():
        if pos in space:
            if c != 2 and c != 3:
                space.remove(pos)
        else:
            if c == 3:
                space.add(pos)

def run(dims):
    space = {(i, j, *([0] * (dims - 2))) for i, j in init}
    for _ in range(6):
        evolve(space, dims)
    print(len(space))

run(3)
run(4)
