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

; zestaw  05
; zadanie 01
;
; Proszę napisać w assemblerze funkcję o nagłówku
; extern "C" double wartosc(double a, double b, double  c, double d, double x);

; wyliczającą wartość wyrażenia y=ax3+bx2+cx+d. Funkcja ma pobierać dane wejściowe od procedury wołającej napisanej w C, która wyświetla wyniki obliczeń.

Function main
    return;
