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
        answers.append({*line})

combine = lambda f, groups: sum(map(len, it.starmap(f, groups)))

groups = [*parse()]
print(combine(set.union, groups))
print(combine(set.intersection, groups))
        
