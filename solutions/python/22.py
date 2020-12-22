import itertools as it
import functools as ft
import pprint as pp
import operator as op
import heapq as hq
import collections as co
import bisect as bs
import random as rn
import sys
import math

def score(deck):
    return sum((i+1) * card for i, card in enumerate(reversed(deck)))

def play1(deck1, deck2):
    deck1, deck2 = co.deque(deck1), co.deque(deck2)
    while deck1 and deck2:
        a, b = deck1.popleft(), deck2.popleft()
        if a > b:
            deck1.extend([a, b])
        else:
            deck2.extend([b, a])
    return deck1 or deck2


def play2(deck1, deck2):
    seen = set()
    deck1, deck2 = co.deque(deck1), co.deque(deck2)
    while deck1 and deck2:
        key = ((*deck1,), (*deck2,))
        if key in seen:
            return True, deck1
        seen.add(key)
        a, b = deck1.popleft(), deck2.popleft()
        win1, _ = (
            play2([*deck1][:a], [*deck2][:b])
            if len(deck1) >= a and len(deck2) >= b
            else (a > b, None)
        )
        if win1:
            deck1.extend([a, b])
        else:
            deck2.extend([b, a])
    return deck1, deck1 or deck2

nums = lambda group: [*map(int, group.split('\n')[1:])]
d1, d2 = map(nums, sys.stdin.read().strip().split("\n\n"))

print(score(play1(d1, d2)))
print(score(play2(d1, d2)[1]))
