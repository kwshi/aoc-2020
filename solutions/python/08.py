import sys
import itertools as it
import collections as co
import functools as ft
import operator as op
import pprint as pp
import math
import string

lines = sys.stdin.read().strip().split('\n')

def run(prog, i):
    acc = ptr = 0
    seen = set()
    while True:
        if ptr in seen:
            return False, acc
            break
        seen.add(ptr)
        if ptr >= len(lines):
            return True, acc

        cmd, n = lines[ptr].split()
        n = int(n)
        if cmd == 'nop' or i == ptr and cmd == 'jmp':
            ptr += 1
            continue
        if cmd == 'acc':
            acc += n
            ptr += 1
            continue
        if cmd == 'jmp' or i == ptr and cmd == 'nop':
            ptr += n
            continue

    return True

print(run(lines, -1)[1])

for i in range(len(lines)):
    ok, n = run(lines, i)
    if ok: print(n)
