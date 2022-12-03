import itertools as it
import collections as co
import functools as ft
import operator as op
import pprint as pp
import sys
import math

def parse_field(s):
    k, v = s.split(': ')
    return k, [(*map(int, p.split('-')),) for p in v.split(' or ')]

def parse():
    fields, mine, nearby = sys.stdin.read().strip().split('\n\n')
    return (
            dict(map(parse_field, fields.split('\n'))),
            [*map(int, mine.split('\n')[1].split(','))],
            [[*map(int, line.split(','))] for line in nearby.split('\n')[1:]],
            )

def valid(fields, v):
    return any(a <= v <= b for rs in fields.values() for a, b in rs)
    
fields, mine, nearby = parse()
print(sum(v for ticket in nearby for v in ticket if not valid(fields, v)))
valids = [ticket for ticket in nearby if all(valid(fields, v) for v in ticket)]

allowed = [{*fields.keys()} for _ in nearby[0]]
for ticket in valids:
    for i, v in enumerate(ticket):
        allowed[i].difference_update([f for f in allowed[i] if not any(a <= v <= b for a, b in fields[f])])

assign = {}
unassigned = {}

pp.pprint(allowed)

#assign = [None] * len(allowed)
#for i in range(len(allowed)):
#    for j, ff in enumerate(allowed):
#        if len(ff) == 1:
#            assign[j] = ff.pop()
#            for fff in allowed:
#                fff.discard(assign[j])
#print(assign)
#
#print(ft.reduce(op.mul, [v for k, v in dict(zip(assign, [*map(int, mine.split('\n')[1].split(','))])).items() if k.startswith('departure')]))


#
#
#
##print(sum(v for row in nearby for v in row if not any(a <= v <= b for vs in s.values()for a, b in vs )))
#
