%include "../../lib_arh64/lib_arh.macro.asm"

section .text   ; the code parto of file

; zestaw  02
; zadanie 01
;
; Proszę napisać program sprawdzający, czy dana liczba jest liczbą pierwszą.
; W wersji podstawowej liczba może być na sztywno wpisana w program.
; W rozszerzonej wczytujemy ją z klawiatury.

; global _start   ; makes it public
; _start:         ; the main() of assembler ; no longer used because of using lib_io64

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

global asm_main
asm_main:
    enter 0,0
main:

    zero    rax, rbx, rcx, rdx

    execIO printf,    str_gimme_a_number
    execIO scanf,     str_pattern_int, long_the_number
    execIO printf,    str_got_a_number, [long_the_number]

    exec f_isPrime, [long_the_number]

    .if: ; if isPrime(num) == true
        cmp     rax, true
        jne     .printNotPrime
    .printPrime:
        execIO printf,    str_is_a_prime, [long_the_number]
        jmp     .end_if
    .printNotPrime:
        execIO printf,    str_is_not_a_prime, [long_the_number]
        jmp     .end_if
    .end_if:

    return;


f_isPrime:
    enter 0,0
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
    cstring     gimme_a_number, "gimme a number for the prime test", NL
    cstring     got_a_number,   "processing number %u for being a prime number", NL
    cstring     is_a_prime,     "number %u is a prime number", NL
    cstring     is_not_a_prime, "number %u is NOT a prime number", NL
    cstring     pattern_int,    "%u"

section .bss    ; UnInitialized data
