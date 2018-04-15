#include <stdio.h>

extern double wartosc(double a, double b, double  c, double d, double x);

int main()
{
  printf("%f\n", wartosc(2., 3., 4., 5.,  1.));
  printf("%f\n", wartosc(2, 3, 4, 5, -1.));
  return 0;
}
/* Wyjście:
 * 14
 * 2
 */ 
