#include <stdio.h>
#include <stdlib.h>

/*/

; zestaw  04
; zadanie 03

; Napisać funkcję o nagłówku
; void sortuj( int * a, int *b, int * c);
; sortującą malejąco wartości trzech podanych zmiennych.
; Po wywołaniu funkcji wartości zmiennych powinny zostać odpowiednio pozamieniane. 

; Na przykład 
; int x=5, y=3, z=4;
; sortuj( &x, &y, &z);
; printf(" %d %d %d \n", x, y, z);

; powinno wypisać 
; 5 4 3

//*/

extern void sort(int * a, int *b, int * c);

void printVector(int size, int* v);

int main()
{
    printf("give three numbers to sort in dec order\n");

    int n1, n2, n3;
    scanf("%i%i%i", &n1, &n2, &n3);

    sort(&n1, &n2, &n3);
    printf("%i >= %i >= %i\n", n1, n2, n3);
}
