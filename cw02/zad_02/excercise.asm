%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"
; %include "fuck_logic.macro.asm"

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called


section .text   ; the code parto of file

; zestaw  02
; zadanie 01
;
; Proszę napisać program wypisujący rozkład zadanej liczby na czynniki pierwsze.
; Można wypisywać posługując się asm_io lub printf.
; Np. dla liczby 60 wyjście powinno zawierać:
; 2 2 3 5

Function main

    zero    rax, rbx, rcx, rdx, rdi, rsi

    execIO  printf,    "gimme a number for the factorization%c", nl
    execIO  scanf,     "%i", long_the_number
    execIO  printf,    "processing number %i for factorization%c", [long_the_number], nl

    zero    rax, rbx, rcx, rdx, rdi, rsi

    mov     rbx, 2

    cmp     [long_the_number], rbx  ; rbx == dzielnik
    jae     .WHILE_do               ; if num < 2 then print and skip WHILE
        execIO  printf,  "%i", [long_the_number]
        jmp     .while_do_BREAK
        
    .WHILE_do: ; while [long_the_number] >= rbx ; rbx == dzielnik
        cmp     [long_the_number], rbx   ; rbx == dzielnik
        jae     .while_DO               ; while num >= dzielnik
        jmp     .while_do_BREAK
    .while_DO:

        divR    [long_the_number], rbx
        .if: ; mod == 0
        cmp     rdx, 0
        je      .then
        jmp     .else
        .then:
            mov     [long_the_number], rax
            execIO  printf,  "%i ", rbx
            jmp     .endIf
        .else:
            inc     rbx
            jmp     .endIf
        .endIf:

        jmp     .WHILE_do
    .while_do_BREAK:

    execIO  printf,  "%c", nl
    
    return;

section .data   ; Initialized data

    long        lowest_prime,       2
    long        the_number,         0

section .bss    ; UnInitialized data
