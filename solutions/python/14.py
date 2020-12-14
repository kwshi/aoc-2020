import itertools as it
import collections as co
import operator as op
import pprint as pp
import functools as ft
import math
import sys

def set_bit(n, i, b):
    return n | 1 << i if b else n & ~(1 << i)

def variations(mask, n, i=0):
    if i == len(mask):
        yield n
        return
    c = mask[-(i+1)]
    if c == 'X':
        yield from variations(mask, n | 1<<i, i+1)
        yield from variations(mask, n & ~(1<<i), i+1)
    elif c == '0':
        yield from variations(mask, n, i+1)
    elif c == '1':
        yield from variations(mask, n | 1<<i, i+1)

def variations_it(mask, n):
    powers = [*(i for i, c in enumerate(mask) if c in '1X')]
    for combo in it.product(*([0, 1] if mask[i] == 'X' else [1] for i in powers)):
        yield ft.reduce((lambda m, p: set_bit(m, *p)), zip(powers, combo), n)

mem1 = {}
mem2 = {}

mask = ''
for line in sys.stdin:
    l, r = line.split(' = ')
    if l == 'mask':
        mask = r.strip()[::-1]
        continue

    pos = int(l[4:-1])
    n = int(r)
    mem1[pos] = n
    for i, b in enumerate(mask): 
        mem1[pos] = mem1[pos] if b == 'X' else set_bit(mem1[pos], i, b == '1')
    for p in variations_it(mask, pos):
        mem2[p] = n

print(sum(mem1.values()))
print(sum(mem2.values()))
