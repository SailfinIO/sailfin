#include <stdio.h>
#include <stdlib.h>

int main() {
  // This is equivalent to: let x: number = 42; let y: number = x + 8;
  int x = 42;
  int y = x + 8;

  printf("x = %d, y = %d\n", x, y);
  return 0;
}
