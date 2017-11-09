#include <stdio.h>
#include <stdlib.h>
// extern int main();
// extern int asm_main();

/*/

; zestaw  04
; zadanie 04

; Napisać moduł asemblerowy implementujący funkcję minmax
; wyliczającą minimalny i maksymalny spośród argumentów funkcji.
; Pierwszym argumentem funkcji jest liczba całkowita N>0
; po której następuje N argumentów całkowitych (patrz uwaga poniżej).   
; Wyniki mają być zwracane jako struktura MM.

; typedef struct{
;     int max;
;     int min;
; } MM;

; MM minmax( int N, ...);

; int main(){
;    MM wynik = minmax(7, 1, -2, 4 , 90, 4, -11, 101);
;    printf("min = %d, max = %d \n", wynik.min, wynik.max);
;    return 0;
; }

; Aplikacja ma być złożona z dwóch modułów w
; - C (operacje IO, wywołanie funkcji ) i
; - ASM (wyznaczenie minimum i maksimum).
; Uwaga: Sposób zwracania zależy od systemu operacyjnego i wersji kompilatora:
; Linux: Jako pierwszy argument funkcji minmax zostanie przekazany
;   wskaźnik na obiekt typu MM, który należy uzupełnić.
; Windows, starsze gcc pod linuxem:
;   Struktura MM mieści się w sumie rejestrów EDX:EAX
;   i tam powinna być zwrócona.

//*/

typedef struct{
    int max;
    int min;
} MM;

extern MM minmax(int N, ...);
// extern MM minmax(int N, ...){MM m;m.min=3;m.max=4;return m;}

int main()
{
    MM wynik = minmax(7, 1, -2, 4 , 90, 4, -11, 101);
    printf("min = %d, max = %d \n", wynik.min, wynik.max);
}
