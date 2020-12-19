import ast
import sys
import math
import pprint as pp
import collections as co
import itertools as it
import functools as ft
import operator as op

rs, ss = sys.stdin.read().strip().split("\n\n")

rules = {}
for line in rs.split("\n"):
    src, dsts = line.split(":")
    rules[int(src)] = [
        [s[1:-1] if s.startswith('"') else int(s) for s in ds.strip().split()]
        for ds in dsts.split("|")
    ]

# comment for part 1
rules[8] = [[42], [42, 8]]
rules[11] = [[42, 31], [42, 11, 31]]

@ft.lru_cache(None)
def match(src, s):
    if isinstance(src, str): return s == src
    dsts = rules[src]
    return any(
        all(
            match(dst[d], s[i:j])
            for d, (i, j) in enumerate(zip([0, *seps], [*seps, len(s)]))
        )
        for dst in dsts
        for seps in it.combinations(range(1, len(s)), len(dst)-1)
    )

print(sum(1 for line in ss.split('\n') if match(0, line)))
