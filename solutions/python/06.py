import functools as ft
import itertools as it
import operator as op
import collections as co
import math
import numpy as np
import sys

def parse():
    answers = []
    for line in sys.stdin:
        line = line.strip()
        if not line:
            yield answers
            answers = []
            continue
        answers.append(line)

def p1():
    for group in parse():
        yield len(ft.reduce(lambda a, b: a & b, map(set, group)))

print(sum(p1()))
        
