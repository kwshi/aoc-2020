import math
import sys
import itertools as it
import collections as co
import pprint as pp

def top(grid):
    return grid[0]

def bottom(grid):
    return grid[-1]

def left(grid):
    return ''.join(row[0] for row in grid)

def right(grid):
    return ''.join(row[-1] for row in grid)

flip_h = lambda grid: [row[::-1] for row in grid]
flip_v = lambda grid: grid[::-1]
rot1 = lambda grid: [
        ''.join(grid[i][j] for i in range(len(grid)))
        for j in range(len(grid[0])-1, -1, -1)
        ]
rot2 = lambda grid: rot1(rot1(grid))
rot3 = lambda grid: rot1(rot2(grid))

tiles = {}

chunks = sys.stdin.read().strip().split('\n\n')
for chunk in chunks:
    fst, *grid = chunk.split('\n')
    n = int(fst.split()[1][:-1])
    tiles[n] = grid

matches = co.defaultdict(list)

borders = {
        't': top,
        'b': bottom,
        'l': left,
        'r': right,
        }

for (i, gi), (j, gj) in it.combinations(tiles.items(), 2):
    for (di, fi), (dj, fj) in it.product(borders.items(), borders.items()):
        bi, bj = fi(gi), fj(gj)
        if bi == bj:
            matches[i].append((di, False, j))
            matches[j].append((dj, False, i))
            break
        if bi[::-1] == bj:
            matches[i].append((di, True, j))
            matches[j].append((dj, True, i))
            break

corners = [k for k, v in matches.items() if len(v) == 2]
print(math.prod(corners))

start = corners[0]
front = co.deque([start])
seen = {start: (0, 0)}
conf = {start: tiles[start]}
while front:
    parent = front.pop()
    gp = conf[parent]
    tp, bp, lp, rp = top(gp), bottom(gp), left(gp), right(gp)
    i, j = seen[parent]
    for _, _, child in matches[parent]:
        if child in seen:
            continue
        front.append(child)

        gc = tiles[child]
        tc, bc, lc, rc = top(gc), bottom(gc), left(gc), right(gc)

        if tc == bp:
            seen[child] = (i+1, j)
            conf[child] = gc
        elif lc == rp:
            seen[child] = (i, j+1)
            conf[child] = gc
        elif bc == tp:
            seen[child] = (i-1, j)
            conf[child] = gc
        elif rc == lp:
            seen[child] = (i, j-1)
            conf[child] = gc

        elif tp == tc:
            seen[child] = (i-1, j)
            conf[child] = flip_v(gc)
        elif bp == bc:
            seen[child] = (i+1, j)
            conf[child] = flip_v(gc)
        elif rp == rc:
            seen[child] = (i, j+1)
            conf[child] = flip_h(gc)
        elif lp == lc:
            seen[child] = (i, j-1)
            conf[child] = flip_h(gc)

        elif tp == tc[::-1]:
            seen[child] = (i-1, j)
            conf[child] = rot2(gc)
        elif bp == bc[::-1]:
            seen[child] = (i+1, j)
            conf[child] = rot2(gc)
        elif rp == rc[::-1]:
            seen[child] = (i, j+1)
            conf[child] = rot2(gc)
        elif lp == lc[::-1]:
            seen[child] = (i, j-1)
            conf[child] = rot2(gc)

        elif tp == bc[::-1]:
            seen[child] = (i-1, j)
            conf[child] = flip_h(gc)
        elif bp == tc[::-1]:
            seen[child] = (i+1, j)
            conf[child] = flip_h(gc)
        elif lp == rc[::-1]:
            seen[child] = (i, j-1)
            conf[child] = flip_v(gc)
        elif rp == lc[::-1]:
            seen[child] = (i, j+1)
            conf[child] = flip_v(gc)

        elif tp == lc:
            seen[child] = (i-1, j)
            conf[child] = rot1(gc)
        elif rp == tc[::-1]:
            seen[child] = (i, j+1)
            conf[child] = rot1(gc)
        elif bp == rc:
            seen[child] = (i+1, j)
            conf[child] = rot1(gc)
        elif lp == bc[::-1]:
            seen[child] = (i, j-1)
            conf[child] = rot1(gc)

        elif tp == lc[::-1]:
            seen[child] = (i-1, j)
            conf[child] = flip_h(rot1(gc))
        elif rp == tc:
            seen[child] = (i, j+1)
            conf[child] = flip_v(rot1(gc))
        elif bp == rc[::-1]:
            seen[child] = (i+1, j)
            conf[child] = flip_h(rot1(gc))
        elif lp == bc:
            seen[child] = (i, j-1)
            conf[child] = flip_v(rot1(gc))

        elif tp == rc:
            seen[child] = (i-1, j)
            conf[child] = rot1(flip_h(gc))
        elif rp == bc[::-1]:
            seen[child] = (i, j+1)
            conf[child] = flip_h(rot1(gc))
        elif bp == lc:
            seen[child] = (i+1, j)
            conf[child] = rot1(flip_h(gc))
        elif lp == tc[::-1]:
            seen[child] = (i, j-1)
            conf[child] = flip_h(rot1(gc))

        elif tp == rc[::-1]:
            seen[child] = (i-1, j)
            conf[child] = rot3(gc)
        elif rp == bc:
            seen[child] = (i, j+1)
            conf[child] = rot3(gc)
        elif bp == lc[::-1]:
            seen[child] = (i+1, j)
            conf[child] = rot3(gc)
        elif lp == tc:
            seen[child] = (i, j-1)
            conf[child] = rot3(gc)

        else:
            raise ValueError('help', parent, child, (tp, bp, lp, rp), (tc, bc, lc, rc))

(i1, j1), (i2, j2) = min(seen.values()), max(seen.values())

pos = {}
for k, p in seen.items():
    pos[p] = k

total = []
for i in range(i1, i2+1):
    row = []
    for j in range(j1, j2+1):
        row.append(pos[i, j])
    total.append(row)

big = []
for r in total:
    lines = [[] for _ in range(len(tiles[start]) - 2)]
    for c in r:
        for i, (l, t) in enumerate(zip(lines, conf[c][1:-1])):
            l += [*t[1:-1]]
    big += lines

big = [*map(''.join, big)]

orientations = {
        'original': lambda g: g,
        'rot1': rot1,
        'rot2': rot2,
        'rot3': rot3,
        'fliph': flip_h,
        'rot1f': lambda g: rot1(flip_h(g)),
        'rot2f': lambda g: rot2(flip_h(g)),
        'rot3f': lambda g: rot3(flip_h(g)),
}
monsters = co.defaultdict(set)
ns = co.defaultdict(int)

mon = [
  '                  # ',
  '#    ##    ##    ###',
  ' #  #  #  #  #  #   ',
]

for name, o in orientations.items():
    g = o(big)
    for i in range(len(g) - len(mon) + 1):
        for j in range(len(g[0]) - len(mon[0]) + 1):
            maybe = set()
            ok = True
            for ii, r in enumerate(mon):
                for jj, c in enumerate(r):
                    if c == ' ':
                        continue
                    if g[i+ii][j+jj] != '#':
                        ok = False
                        break
                    maybe.add((i+ii, j+jj))
            if ok: 
                monsters[name] |= maybe
                ns[name] += 1
print(len([*monsters.values()][0]))
print(''.join(big).count('#') - len([*monsters.values()][0]))
