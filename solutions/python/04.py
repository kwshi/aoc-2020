import sys
import pprint as pp
import functools as ft

required = {*'byr iyr eyr hgt hcl ecl pid'.split()}

def parse():
    pport = {}
    for line in sys.stdin:
        line = line.strip()
        if not line:
            yield pport
            pport = {}
            continue
        for p in line.strip().split():
            k, v = p.split(':')
            pport[k] = v

    if pport:
        yield pport

def has_keys(pport):
    for k in required:
        if k not in pport:
            return False
    return True

def valid(pport):
    if not has_keys(pport):
        return False

    hgt = pport['hgt']
    hcl = pport['hcl']
    ecl = pport['ecl']
    pid = pport['pid']

    return all([
        1920 <= int(pport['byr']) <= 2002,
        2010 <= int(pport['iyr']) <= 2020,
        2020 <= int(pport['eyr']) <= 2030,
        hgt.endswith('cm') and 150 <= int(hgt[:-2]) <= 193
        or hgt.endswith('in') and 59 <= int(hgt[:-2]) <= 76,
        hcl.startswith('#') and all('0' <= c <= '9' or 'a' <= c <= 'f'for c in hcl[1:]),
        ecl in 'amb blu brn gry grn hzl oth'.split(),
        len(pid) == 9 and all('0' <= c <= '9' for c in pid)
    ])

print(ft.reduce(lambda s, p: (s[0] + int(has_keys(p)), s[1] + int(valid(p))), parse(), (0,0)))
