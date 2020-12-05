import sys

valid1 = 0
valid2 = 0
for line in sys.stdin:
    policy, pwd = line.strip().split(': ')
    num, c = policy.split()
    min, max = map(int, num.split('-'))
    valid1 += int(min <= pwd.count(c) <= max)
    valid2 += int(pwd[min-1] == c) != (pwd[max-1] == c)

print(valid1, valid2)
