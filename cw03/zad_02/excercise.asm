%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"
%include "fuck_logic.macro.asm"

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

section .data   ; Initialized data

    int     array, 1, 2, 3, 13, 4, 5, 6, 7, 8, 9, 0, 9, 12
    long    array.len, 13

section .bss    ; UnInitialized data

section .text   ; the code part of file

; zestaw  03
; zadanie 02
;
; Zaimplementować funkcję szukającą elementu maksymalnego w tablicy liczb typu int (32 bitowe).
; Przed wywołaniem funkcji na stosie znajdują się liczba elementów tablicy i wskaźnik na pierwszy element tablicy. 
; Funkcja powinna samodzielnie posprzątać te dane ze stosu (proszę uważać na adres powrotu).
; Po powrocie z funkcji element maksymalny powinien znajdować się w rejestrze RAX. 

Function main

    push    long_array.len, int_array
    exec    getMaxElem
    mov     rbx, rax

    execIO  printf, "max element is %i%c", rbx, nl
    return;


function getMaxElem
    push rbx

    mov     rbx, [rbp + long.size + long.size * 1] ; [**array] = *array
    mov     rcx, [rbp + long.size + long.size * 2] ; [**array.len] = *array.len
    mov     rcx, [rcx] ; [*array.len] = array.len
    mov     rdx, 0
    mov     edx, [rbx] ; maxElem = array[0]

    defArray integers, int.size, rbx

    dec     rcx
    while   rcx, ge, 0
        execIO_safe printf, "processing value %i%c", integers(rcx), nl
        if  integers(rcx), g, edx
            mov     edx, integers(rcx)
        endif
        dec     rcx
    endwhile

    pop rbx
    return rdx, long.size * 2;
