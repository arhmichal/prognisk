%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"
%include "fuck_logic.macro.asm"

; %define DEBUG_ON

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

section .data   ; Initialized data

section .bss    ; UnInitialized data

section .text   ; the code parto of file

; zestaw  05
; zadanie 02
;
; Proszę napisać funkcję asemblerową o nagłówku
; extern "C" void prostopadloscian( float a, float b, float c, float * objetosc, float * pole);
; wyliczającą objętość i pole powierzchni prostopadłościanu a. Funkcja ma pobierać dane wejściowe od procedury wołającej napisanej w C, która wyświetla wyniki obliczeń.

Function main;() return void

    return;
