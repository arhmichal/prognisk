%include "lib_arh.macro.asm"
%include "fuck_functions.macro.asm"
%include "fuck_logic.macro.asm"

; %define DEBUG_ON

; extern  printf  ; the C function, to be called
; extern  scanf   ; the C function, to be called

section .data   ; Initialized data
    int max, 0
    int min, 0

section .bss    ; UnInitialized data

section .text   ; the code parto of file

; zestaw  04
; zadanie 04
;

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
;
; Aplikacja ma być złożona z dwóch modułów w
; - C (operacje IO, wywołanie funkcji ) i
; - ASM (wyznaczenie minimum i maksimum).
; Uwaga: Sposób zwracania zależy od systemu operacyjnego i wersji kompilatora:
; Linux: Jako pierwszy argument funkcji minmax zostanie przekazany
;   wskaźnik na obiekt typu MM, który należy uzupełnić.
; Windows, starsze gcc pod linuxem:
;   Struktura MM mieści się w sumie rejestrów EDX:EAX
;   i tam powinna być zwrócona.

Function minmax;(int N, ...); N>0 return struct MM
; IMPORTANT ; translates to
;      ; minmax(MM* return_struct_ptr, int N, ...) return void

    defineParamIn args(0), retStruct, edi
    defineParam args(1), vecSize
    defArray numbersVector, stackElement.size, rebp+stackElement.size*2+stackElement.size*2

    movVia(eax) [int_max], args(1)
    movVia(eax) [int_min], args(1)

    zero ecx
    while ecx, le, vecSize
        mov eax, numbersVector(ecx)
        if eax, l, [int_min]
            mov [int_min], eax
        endif
        if eax, g, [int_max]
            mov [int_max], eax
        endif
        inc ecx
    endwhile

    movVia(eax) [edi], [int_max]
    movVia(eax) [edi+int.size], [int_min]

    return;
