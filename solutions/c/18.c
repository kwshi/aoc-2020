#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

char line[1024];

int atom(int (*expr)(size_t), size_t i) {
  if (line[i] == '(') return expr(++i) + 1;
  int n; sscanf(&line[i], "%d", &n);
}

int expr1(size_t i) {
}

int expr2(size_t i) {
}

int main() {
  while (fgets(line, 1024, stdin)) {
  }
}
