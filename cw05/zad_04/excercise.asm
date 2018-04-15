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
; zadanie 04
;
; Proszę napisać funkcję asemblerową tablicującą wartości funkcji:
;     y=a*(sin(P*2*pi*x))2 + b*(sin(Q*2*pi*x))2
; dla k>=2 równoodległych punktów w przedziale od xmin do xmax.(tj.  x1 = xmin ... xk = xmax )
; Funkcja ma pobierać dane wejściowe od procedury wołającej napisanej w C, która wyświetla wyniki obliczeń.
; Funkcja ma mieć nagłówek
; extern "C" void tablicuj(double a, double b, double P, double Q, double xmin, double xmax, int k,  double * wartosci);
; Wynik ma być zapisany w tablicy wartosci (zakladamy, że jest odpowiednio duza);

Function main;() return void

    return;
