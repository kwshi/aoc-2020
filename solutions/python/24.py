import itertools as it
import collections as co
import functools as ft
import re
import sys

disp = {
    "w": (-1, 0),
    "e": (1, 0),
    "nw": (0, 1),
    "ne": (1, 1),
    "sw": (-1, -1),
    "se": (0, -1),
}

instructions = sys.stdin.read().strip().split("\n")
re_step = re.compile("[ns]?[ew]")
add = lambda a, b: (a[0] + b[0], a[1] + b[1])
move = lambda steps: ft.reduce(add, (disp[d] for d in re_step.findall(steps)))
count = lambda sp: [*sp.values()].count(True)

space = co.defaultdict(bool)
for pos in map(move, instructions):
    space[pos] = not space[pos]
print(count(space))

for _ in range(100):
    counts = co.defaultdict(int)
    for pos, black in space.items():
        if black:
            for neighbor in map(ft.partial(add, pos), disp.values()):
                counts[neighbor] += 1
    space = {
        p: c <= 2 and c != 0 if space.get(p, False) else c == 2
        for p, c in counts.items()
    }
print(count(space))
