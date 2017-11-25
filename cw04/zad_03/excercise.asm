%include "lib_arh.macro.asm"
%include "fuck_functions.macro.asm"
%include "fuck_logic.macro.asm"

; %define DEBUG_ON

; extern  printf  ; the C function, to be called
; extern  scanf   ; the C function, to be called

section .data   ; Initialized data

section .bss    ; UnInitialized data

section .text   ; the code parto of file

; zestaw  04
; zadanie 03
;
; Napisać funkcję o nagłówku
; void sortuj( int * a, int *b, int * c);
; sortującą malejąco wartości trzech podanych zmiennych.
; Po wywołaniu funkcji wartości zmiennych powinny zostać odpowiednio pozamieniane. 
;
; Na przykład 
; int x=5, y=3, z=4;
; sortuj( &x, &y, &z);
; printf(" %d %d %d \n", x, y, z);
;
; powinno wypisać 
; 5 4 3

Function sort;(int * a, int *b, int * c) return void

    defineParamIn args(0), ptrA, edi
    defineParamIn args(1), ptrB, esi
    defineParamIn args(3), ptrC, edx

    mov eax, [ptrA]
    mov ecx, [ptrB]
    if eax, l, ecx
        mov [ptrA], ecx
        mov [ptrB], eax
    endif

    mov eax, [ptrB]
    mov ecx, [ptrC]
    if eax, l, ecx
        mov [ptrB], ecx
        mov [ptrC], eax
    endif

    mov eax, [ptrA]
    mov ecx, [ptrB]
    if eax, l, ecx
        mov [ptrA], ecx
        mov [ptrB], eax
    endif

    return;
