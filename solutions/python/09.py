import sys
import collections as co
import itertools as it
import pprint as pp

def bad(nums, pre):
    last = co.deque(nums[:pre])
    sums = co.defaultdict(int)
    for m, n in it.combinations(last, 2):
        sums[m + n] += 1

    for n in nums[pre:]:
        if sums[n] == 0:
            return n
        k = last.popleft()
        for m in last:
            sums[k + m] -= 1
            sums[m + n] += 1
        last.append(n)

def find(nums, n):
    acc = i = j = 0
    while acc != n or i + 1 == j:
        if acc < n:
            acc += nums[j]
            j += 1
        else:
            acc -= nums[i]
            i += 1
    
    return i, j


nums = [*map(int, sys.stdin)]
b = bad(nums, 25)
print(b)

i, j = find(nums, b)
print(min(nums[i:j]) + max(nums[i:j]))
