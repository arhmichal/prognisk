%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"

section .data   ; Initialized data

section .bss    ; UnInitialized data

section .text   ; the code parto of file

; zestaw  03
; zadanie 02
;
; Zaimplementować funkcję szukającą elementu maksymalnego w tablicy liczb typu int (32 bitowe).
; Przed wywołaniem funkcji na stosie znajdują się liczba elementów tablicy i wskaźnik na pierwszy element tablicy. 
; Funkcja powinna samodzielnie posprzątać te dane ze stosu (proszę uważać na adres powrotu).
; Po powrocie z funkcji element maksymalny powinien znajdować się w rejestrze RAX. 

  global asm_main
function asm_main
    return;
