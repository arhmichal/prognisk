%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"
%include "fuck_logic.macro.asm"

; %define DEBUG_ON

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

section .data   ; Initialized data
    int a, 0
    int b, 0

section .bss    ; UnInitialized data

section .text   ; the code parto of file

; zestaw  04
; zadanie 01
;
; Napisać w assemblerze funkcję main, która wczytuje dwie liczby całkowite
; przy użyciu funkcji scanf z biblioteki standardowej języka C
; i wypisujący na ekran ich iloraz przy użyciu funkcji printf.
; Należy przysłać tylko plik ASM.

Function main

    execIO  scanf, "%i%i", int_a, int_b
    divE    [int_a], _32b [int_b]
    execIO  printf, "%i / %i = %i r %i%c", _32b [int_a], _32b [int_b], eax, edx, nl

    return;
