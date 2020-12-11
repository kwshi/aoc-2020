#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *const a, const void *const b) {
  return (*(int*)a - *(int*)b);
}

int diffs(const int *const nums, const size_t size) {
  int ds[2] = {0, 0};
  for (size_t i = 0; i < size; ++i)
    switch (nums[i] - (i ? nums[i-1] : 0)) {
      case 1: ++ds[0]; break;
      case 3: ++ds[1]; break;
    }
  return ds[0] * (ds[1] + 1);
}

long count(const int *const nums, const size_t size) {
  long *cts = malloc(sizeof(long) * size);
  memset(cts, 0, sizeof(long) * size);
  for (size_t i = 0; i < size; ++i) {
    cts[i] = nums[i] <= 3;
    for (size_t j = i-1; j != (size_t)-1; --j) {
      if (nums[i] - nums[j] > 3) break;
      cts[i] += cts[j];
    }
  }
  long c = cts[size-1];
  free(cts);
  return c;
}

int main() {
  size_t cap = 4;
  size_t size = 0;
  int *nums = malloc(sizeof(int) * cap);
  for (;;) {
    int n;
    if (scanf(" %d", &n) == EOF) break;
    if (size == cap) nums = realloc(nums, sizeof(int) * (cap <<= 1));
    nums[size++] = n;
  }

  qsort(nums, size, sizeof(int), compare);

  printf("%d\n", diffs(nums, size));
  printf("%ld\n", count(nums, size));

  free(nums);
  return 0;
}
