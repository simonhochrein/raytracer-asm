#include <stdio.h>

struct vec3 {
  double r,g,b;
};
typedef struct vec3 vec3;

extern void vec3_mul(vec3*, vec3*);

int main() {
  vec3 a = { 1.0, 2.0, 3.0 };
  vec3 b = { 1.0, 2.0, 3.0 };
  vec3_mul(&a, &b);
  printf("%f %f %f\n", a.r, a.g, a.b);
}
