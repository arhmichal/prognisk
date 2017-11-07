%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"
%include "fuck_logic.macro.asm"

; %define DEBUG_ON

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

section .data   ; Initialized data
    long a, 0
    long b, 0

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

    execIO  scanf, "%i%i", long_a, long_b
    divR    [long_a], _64b [long_b]
    mov     r8, rax
    mov     r9, rdx
    execIO  printf, "%i / %i = %i r %i%c", [long_a], [long_b], r8, r9, nl

    return;
