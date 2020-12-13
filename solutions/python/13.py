import operator as op
import sys
from sympy.ntheory.modular import crt

n = int(sys.stdin.readline())
offsets, buses = zip(
    *(
        (i, int(bus))
        for i, bus in enumerate(sys.stdin.readline().strip().split(","))
        if bus != "x"
    )
)

b = min(buses, key=lambda k: -n % k)
print(b * (-n % b))
print(crt(buses, map(op.neg, offsets))[0])
