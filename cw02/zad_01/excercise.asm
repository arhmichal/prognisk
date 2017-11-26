%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"
; %include "fuck_logic.macro.asm"

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

section .text   ; the code parto of file

; zestaw  02
; zadanie 01
;
; Proszę napisać program sprawdzający, czy dana liczba jest liczbą pierwszą.
; W wersji podstawowej liczba może być na sztywno wpisana w program.
; W rozszerzonej wczytujemy ją z klawiatury.

Function main

    zero    rax, rbx, rcx, rdx

    execIO printf,    "gimme a number for the prime test%c", nl
    execIO scanf,     "%u", long_the_number
    execIO printf,    "processing number %u for being a prime number%c", [long_the_number], nl

    exec f_isPrime, [long_the_number]

    .if: ; if isPrime(num) == true
        cmp     rax, true
        jne     .printNotPrime
    .printPrime:
        execIO printf,    "number %u is a prime number%c", [long_the_number], nl
        jmp     .end_if
    .printNotPrime:
        execIO printf,    "number %u is NOT a prime number%c", [long_the_number], nl
        jmp     .end_if
    .end_if:

    return;


function f_isPrime
    zero    rax, rbx, rcx, rdx

    mov     rax, fArg0
    cmp     rax, 2
    je      .isPrime
    jb      .isNotPrime
    ja      .dunnoYet

    .isPrime:
        return true;

    .isNotPrime:
        return false;

    .dunnoYet:
        mov     rcx, fArg0
        dec     rcx

        .WHILE_do:
            cmp     rcx, 2
            jae     .while_DO
            jmp     .while_do_BREAK
        .while_DO:

            divR    fArg0, rcx
            .if: ; if arg % ecx == 0
                cmp     rdx, 0
                je      .isNotPrime
            dec     rcx

            jmp     .WHILE_do
        .while_do_BREAK:

    return true;



section .data   ; Initialized data

    long        lowest_prime,   2
    long        the_number,     4

section .bss    ; UnInitialized data
