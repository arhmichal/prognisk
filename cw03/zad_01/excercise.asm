%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"

section .data   ; Initialized data

section .bss    ; UnInitialized data

section .text   ; the code parto of file

; zestaw  03
; zadanie 01
;
; Zaimplementować program wczytujący liczby całkowite ze znakiem
; i odkładający je na stos aż do wczytania 0.
; Następnie wczytujemy dodatkową liczbę całkowitą A.
; Na ekran należy wypisać
; ilość wczytanych liczb mniejszych od A. 

  global asm_main
function asm_main
    return;
