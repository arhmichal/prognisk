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

; zestaw  05
; zadanie 03
;
; Proszę napisać funkcję asemblerową o nagłówku
; extern "C" long double iloczyn_skalarny(int n, long double * x, long double * y);
; mnożącą skalarnie dwa n-wymiarowe wektory liczb rzeczywistych o współrzędnych w tablicach x i y. 
; Funkcja ma pobierać dane wejściowe od procedury wołającej napisanej w C, która wyświetla wyniki obliczeń.

Function main;() return void

    return;
