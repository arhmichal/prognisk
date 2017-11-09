%include "lib_arh.macro.asm"
; %include "fuck_io.macro.asm"
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

Function sort;(int * a, int *b, int * c)
    zero rax, rcx

    mov eax, [fArg0]
    mov ecx, [fArg1]
    if eax, l, ecx
        mov [fArg0], ecx
        mov [fArg1], eax
    endif

    mov eax, [fArg1]
    mov ecx, [fArg2]
    if eax, l, ecx
        mov [fArg1], ecx
        mov [fArg2], eax
    endif

    mov eax, [fArg0]
    mov ecx, [fArg1]
    if eax, l, ecx
        mov [fArg0], ecx
        mov [fArg1], eax
    endif

    return;
