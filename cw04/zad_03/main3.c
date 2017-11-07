// KOMPILACJA - kod źródłowy C w main3.c, kod źródłowy ASM w sort.asm
// LINUX :
// nasm -felf32 sort.asm -o sort.o
// gcc -m32 -o main3.o -c main3.c
// gcc -m32 main3.o sort.o -o sort
// 

//Napisać funkcję o nagłówku
//void sortuj( int * a, int *b, int * c);
//sortującą malejąco wartości trzech podanych zmiennych.
//Po wywołaniu funkcji wartości zmiennych powinny zostać odpowiednio pozamieniane. 


#include <stdio.h>

void sort( int * a, int *b, int * c);         /* prototyp funkcji */

int main() {
	int x=5, y=3, z=4;
	sort( &x, &y, &z);
	printf("%d %d %d \n", x, y, z);
    return 0;
}
