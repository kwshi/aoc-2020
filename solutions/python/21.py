import math
import sys
import pprint as pp
import operator as op
import collections as co
import itertools as it
import functools as ft

lines = sys.stdin.read().strip().split('\n')
#edges = []
#graph = co.defaultdict(list)
#srcs = set()
#sinks = set()
entries = []
options = co.defaultdict(list)
allergens = set()
ingredients = set()
for line in lines:
    ings, alls = line.rstrip(')').split(' (contains ')
    ings = {*ings.strip().split()}
    alls = {*alls.strip().split(', ')}
    entries.append((ings, alls))
    allergens.update(alls)
    ingredients.update(ings)
    for a in alls:
        options[a].append(ings)

allowed = {a: set.intersection(*ings) for a, ings in options.items()}
free = ingredients - set.union(*allowed.values())

print('\n'.join(f'{i} {a}' for a, ings in allowed.items() for i in ings))
print(sum(int(f in ings) for f in free for ings, _ in entries))

graph = co.defaultdict(set)
for a, ings in allowed.items():
    for i in ings:
        graph[a].add(i)
        graph[i].add(a)

assign = {}
leaf = [k for k, v in graph.items() if len(v) == 1]
front = co.deque(leaf)
while front:
    parent = front.pop()
    if parent in assign:
        assert graph[parent] == {assign[parent]}
    child, = graph[parent]
    assign[parent] = child
    assign[child] = parent
    for grand in graph[child]:
        neighbors = graph[grand]
        neighbors.remove(child)
        if len(neighbors) == 1:
            front.append(grand)

print(','.join(assign[a] for a in sorted(allergens)))
