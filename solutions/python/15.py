import itertools as it
import collections as co
import functools as ft
import operator as op
import pprint as pp
import sys
import math

#input = '0,13,16,17,1,10,6'
input='0,3,6'

llast = {}
last = {}
for turn, n in enumerate(map(int, input.split(','))):
    print(turn+1, n)
    last[n] = turn

turn += 1

def speak(k):
    if turn+1 == 30000000:
        print(k)
    print(turn+1, k)
    if k in last: llast[k] = last[k]
    last[k] = turn
    global n
    n = k

while True:
    if n not in llast:
        speak(0)
    else:
        speak(last[n] - llast[n])
    turn += 1
    if turn > 1000:
        break


