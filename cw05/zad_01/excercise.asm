%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"
%include "fuck_logic.macro.asm"
%include "fuck_floats.macro.asm"

; %define DEBUG_ON

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

section .data   ; Initialized data

section .bss    ; UnInitialized data

section .text   ; the code parto of file

; zestaw  05
; zadanie 01
;
; Proszę napisać w assemblerze funkcję o nagłówku
; extern "C" double wartosc(double a, double b, double  c, double d, double x);

; wyliczającą wartość wyrażenia y=ax3+bx2+cx+d. Funkcja ma pobierać dane wejściowe od procedury wołającej napisanej w C, która wyświetla wyniki obliczeń.

Function wartosc;(double a, double b, double  c, double d, double x) return double
    ; fildimm -12

    defArray args, double.size, rebp+stackElement.size*2 ; not working :(

    fild double.cast args(0)
    fild double.cast args(1)
    fild double.cast args(2)
    fild double.cast args(3)
    fild double.cast args(4)
    return;
