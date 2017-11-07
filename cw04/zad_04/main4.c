// KOMPILACJA - kod źródłowy C w main4.c, kod źródłowy ASM w minmax.asm
// LINUX :
// nasm -felf32 minmax.asm -o minmax.o
// gcc -m32 -o main4.o -c main4.c
// gcc -m32 main4.o minmax.o -o minmax
// 

//Napisać moduł asemblerowy implementujący funkcję minmax  
//wyliczającą minimalny i maksymalny spośród argumentów funkcji. 
//Pierwszym argumentem funkcji jest liczba całkowita N>0, 
//po której następuje N argumentów całkowitych (patrz uwaga poniżej).   
//Wyniki mają być zwracane jako struktura MM.

#include <stdio.h>

typedef struct{
    int max;
    int min;
} MM;

MM minmax(int N, ...);

int main() {
	
   MM wynik = minmax(7, 1, -2, 4 , 90, 4, -11, 201);
   printf("min = %d, max = %d \n", wynik.min, wynik.max);
   
   return 0;
}
