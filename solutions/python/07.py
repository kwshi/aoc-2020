import itertools as it
import collections as co
import functools as ft
import operator as op
import pprint as pp
import re
import sys
import math
import string

def parse_part(s):
    num, *bag = s.split()[:-1]
    return ' '.join(bag), int(num)

def parse_rule(s):
    s = s.strip()
    parent, parts = s.split(' bags contain ')
    return (
        parent, 
        {} if parts == 'no other bags.' else 
        dict(map(parse_part, parts.split(', '))),
    )

def search(graph, source):
    front = co.deque([source])
    seen = set()
    while front:
        bag = front.pop()
        for parent in graph[bag]:
            if parent in seen:
                continue
            front.append(parent)
            seen.add(parent)
    return seen

@ft.lru_cache(0)
def count(graph, source):
    return sum(n * (1 + count(graph, child)) for child, n in graph[source].items())

rdeps = co.defaultdict(list)
deps = {}
for parent, parts in map(parse_rule, sys.stdin):
    deps[parent] = parts
    for part in parts.keys():
        rdeps[part].append(parent)

print(len(search(rdeps, 'shiny gold')))
print(count(deps, 'shiny gold'))
