// KOMPILACJA - kod źródłowy C w main2.c, kod źródłowy ASM w mul_vector.asm
// LINUX :
// nasm -felf32 mul_vector.asm -o mul_vector.o
// gcc -m32 -o main2.o -c main2.c
// gcc -m32 main2.o mul_vector.o -o mul_vector
// 
#include <stdio.h>

int mul_vector (int a, int *b);         /* prototyp funkcji */

int main() {
	int size;
	int tmp;
	
	//wczytanie rozmiaru wektora
	scanf("%d", &size);
	
	//wczytanie elementow wektora
	int vector[size];
	for (int i=0; i < size; i++ ) {
		scanf("%d", &tmp);
		vector[i] = tmp;
	}
    
    printf("%d\n", mul_vector(size, vector));  
    return 0;
}
