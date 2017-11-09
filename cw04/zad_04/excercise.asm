%include "lib_arh.macro.asm"
; %include "fuck_io.macro.asm"
%include "fuck_functions.macro.asm"
%include "fuck_logic.macro.asm"

; %define DEBUG_ON

; extern  printf  ; the C function, to be called
; extern  scanf   ; the C function, to be called

section .data   ; Initialized data
    int max, 0
    int min, 0

section .bss    ; UnInitialized data

section .text   ; the code parto of file

; zestaw  04
; zadanie 04
;

; Napisać moduł asemblerowy implementujący funkcję minmax
; wyliczającą minimalny i maksymalny spośród argumentów funkcji.
; Pierwszym argumentem funkcji jest liczba całkowita N>0
; po której następuje N argumentów całkowitych (patrz uwaga poniżej).   
; Wyniki mają być zwracane jako struktura MM.

; typedef struct{
;     int max;
;     int min;
; } MM;

; MM minmax( int N, ...);

; int main(){
;    MM wynik = minmax(7, 1, -2, 4 , 90, 4, -11, 101);
;    printf("min = %d, max = %d \n", wynik.min, wynik.max);
;    return 0;
; }
;
; Aplikacja ma być złożona z dwóch modułów w
; - C (operacje IO, wywołanie funkcji ) i
; - ASM (wyznaczenie minimum i maksimum).
; Uwaga: Sposób zwracania zależy od systemu operacyjnego i wersji kompilatora:
; Linux: Jako pierwszy argument funkcji minmax zostanie przekazany
;   wskaźnik na obiekt typu MM, który należy uzupełnić.
; Windows, starsze gcc pod linuxem:
;   Struktura MM mieści się w sumie rejestrów EDX:EAX
;   i tam powinna być zwrócona.

Function minmax;(int N, ...); N>0
; IMPORTANT ; ; minmax(MM* return struct, int N, ...)
    push rbx

    ; ; ;
    .initial_min_max_values:
    ; ; ;
    mov [int_max], fArg1_32
    mov [int_min], fArg1_32

    ; ; ;
    .gather_all_params_on_stack:
    ; ; ;
    mov rbx, fArg0

    if rbx, g, 5
        defArray oldStackParams, long.size, rbp + long.size + long.size*1
        sub rbx, 6
        while rbx, ge, 0
            mov rax, oldStackParams(rbx)
            push rax
            dec rbx
        endwhile
    endif

    if fArg0, ge, 5
        push fArg5
    endif
    if fArg0, ge, 4
        push fArg4
    endif
    if fArg0, ge, 3
        push fArg3
    endif
    if fArg0, ge, 2
        push fArg2
    endif
    if fArg0, ge, 1
        push fArg1
    endif

    ; ; ;
    .actual_go_over_all_params:
    ; ; ;
    mov rbx, rsp
    defArray stackParams, long.size, rbx

    zero rcx
    while rcx, le, fArg0
        mov rax, stackParams(rcx)
        if eax, l, [int_min]
            mov [int_min], eax
        endif
        if eax, g, [int_max]
            mov [int_max], eax
        endif
        inc rcx
    endwhile

    ; ; ;
    .wird_way_to_return:
    ; ; ;
    mov rax, [int_max]
    ror rax, int.size * byteInBits
    mov ax, _16b [int_min]

    pop rbx
    return rax;
