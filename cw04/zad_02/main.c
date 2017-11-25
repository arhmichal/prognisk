#include <stdio.h>
#include <stdlib.h>

/*/

; zestaw  04
; zadanie 02

; Napisać aplikację wyliczającą iloczyn elementów wektora danych.
; Aplikacja ma być złożona z dwóch modułów:
; - w C (inicjalizacja wektora, operacje IO):
; - w ASM (wyliczenie iloczynu)
; argumentami dla funkcji jest
; - ilość elementów tablicy i
; - wskaźnik na pierwszy element tablicy.

//*/

extern int vectorProduct(int size, int* v);

void printVector(int size, int* v);

int main()
{
    printf("give size and a vector of ints, will calculate product\n");

    int size = 0;
    scanf("%u", &size);

    int* vector = (int*) malloc(size * sizeof(int));
    for(int i=0;i<size;i++)
        scanf("%i", &vector[i]);
    printVector(size, vector);

    int product = vectorProduct(size, vector);
    printf("product = %i\n", product);

    free(vector);
}

void printVector(int size, int* v)
{
    printf("vector[%u] = [", size);
    if (size > 0)
        printf("%i", v[0]);
    for(int i=1;i<size;i++)
        printf(", %i", v[i]);
    printf("]\n");
}
