import itertools as it
import sys

read = lambda: int(next(sys.stdin))

def find_loops(n):
    k = 1
    for i in it.count():
        if k == n: return i
        k = k * 7 % 20201227

print(pow(read(), find_loops(read()), 20201227))
