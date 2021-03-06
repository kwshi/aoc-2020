import collections as co
import itertools as it
import functools as ft
import pprint as pp
import operator as op
import re
import sys
import math
import enum
import ast

class Transform(ast.NodeTransformer):
    def visit_Call(self, _):
        raise ValueError('disallowing function calls, for safety')

class Transform1(Transform):
    def visit_Sub(self, _):
        return ast.Mult()

class Transform2(Transform):
    def visit_Mult(self, _):
        return ast.Add()

    def visit_Add(self, _):
        return ast.Mult()

def expr1_ast(s):
    return eval(ast.unparse(Transform1().visit(ast.parse(s.replace('*', '-'), mode='eval'))))

def expr2_ast(s):
    return eval(ast.unparse(Transform2().visit(ast.parse(s.replace('*', '_').replace('+', '*').replace('_', '+'), mode='eval'))))

ops = {'*': op.mul, '+': op.add}

def atom(pe, s, i):
    if s[i] == '(':
        e, i = pe(s, i+1)
        return e, i+1
    return int(s[i]), i+1

def expr1(s, i=0):
    acc, i = atom(expr1, s, i)
    while i != len(s) and s[i] != ')':
        o, (v, i) = s[i], atom(expr1, s, i+1)
        acc = ops[o](acc, v)
    return acc, i

def expr2(s, i=0):
    acc_prod = 1
    acc_sum, i = atom(expr2, s, i)
    while i != len(s) and s[i] != ')':
        o, (v, i) = s[i], atom(expr2, s, i+1)
        if o == '+':
            acc_sum += v
        else:
            acc_prod *= acc_sum
            acc_sum = v
    return acc_prod * acc_sum, i

def sum_parse(p, ls):
    return sum(p(l)[0] for l in ls)

lines = [line.strip().replace(' ', '') for line in sys.stdin]
print(sum_parse(expr1, lines), sum(map(expr1_ast, lines)))
print(sum_parse(expr2, lines), sum(map(expr2_ast, lines)))

