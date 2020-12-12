#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

char *grid;
size_t grid_cap = 128;
size_t grid_size = 0;
size_t grid_cols = 0;
size_t grid_rows = 0;

size_t *adj;
size_t adj_cap = 128;
size_t adj_size = 0;

size_t *neighbors;

void grid_push(char c) {
  if (c == '\n') { ++grid_rows; return; }
  if (grid_size == grid_cap) grid = realloc(grid, grid_cap <<= 1);
  grid[grid_size++] = c;
}

void adj_push(const size_t i, const size_t j, const size_t ii, const size_t jj) {
  if (adj_size == adj_cap) adj = realloc(adj, (adj_cap <<= 1) * sizeof(*adj));
  adj[adj_size++] = (i*grid_cols+j) * grid_size + (ii*grid_cols+jj);
}

void look(const size_t i, const size_t j, const size_t di, const size_t dj, const bool move) {
  size_t ii = i + di, jj = j + dj;
  while (0 <= ii && ii < grid_rows && 0 <= jj && jj < grid_cols) {
    if (grid[ii*grid_cols+jj] != '.') { adj_push(i, j, ii, jj); break; }
    if (!move) break;
    ii += di; jj += dj;
  }
}

void adj_build(const bool move) {
  adj_size = 0;
  for (size_t i = 0; i < grid_rows; ++i) {
    for (size_t j = 0; j < grid_cols; ++j) {
      if (grid[i*grid_cols+j] == '.') continue;
      look(i, j, 1, 0, move);
      look(i, j, 1, 1, move);
      look(i, j, 0, 1, move);
      look(i, j, -1, 1, move);
    }
  }
}

bool evolve(char *const frame, size_t thres) {
  memset(neighbors, 0, grid_size * sizeof(*neighbors));
  for (size_t i = 0; i < adj_size; ++i) {
    const size_t j = adj[i]/grid_size, k = adj[i]%grid_size;
    neighbors[j] += frame[k] == '#';
    neighbors[k] += frame[j] == '#';
  }

  bool updated = false;
  for (size_t i = 0; i < grid_size; ++i) {
    const bool off = frame[i] == '#' && neighbors[i] >= thres;
    const bool on = frame[i] == 'L' && !neighbors[i];
    frame[i] += off * ('L' - '#') + on * ('#' - 'L');
    updated = updated || off || on;
  }
  return updated;
}

size_t stabilize(bool move, size_t thres) {
  char *const frame = malloc(grid_size);
  memcpy(frame, grid, grid_size);
  adj_build(move);
  for (bool update = true; update;) update = evolve(frame, thres);
  size_t count = 0;
  for (size_t i = 0; i < grid_size; ++i) count += frame[i] == '#';
  free(frame);
  return count;
}

int main() {
  grid = malloc(grid_cap);
  adj = malloc(adj_cap * sizeof(*adj));

  char c;
  while (scanf("%c", &c) != EOF) grid_push(c);
  grid_cols = grid_size/grid_rows;
  neighbors = malloc(grid_size * sizeof(size_t));

  printf("%zu %zu\n", stabilize(false, 4), stabilize(true, 5));

  free(grid);
  free(adj);
  free(neighbors);
  return 0;
}
