%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"
%include "fuck_logic.macro.asm"

; %define DEBUG_ON

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

section .data   ; Initialized data

section .bss    ; UnInitialized data

section .text   ; the code parto of file

; zestaw  04
; zadanie 02
;
; Napisać aplikację wyliczającą iloczyn elementów wektora danych. Aplikacja ma być złożona z dwóch modułów:
;      w C (inicjalizacja wektora, operacje IO):  
;     w ASM (wyliczenie iloczynu) argumentami dla funkcji jest ilość elementów tablicy i wskaźnik na pierwszy element tablicy.

Function asm_main
    return;
