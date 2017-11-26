%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"
; %include "fuck_logic.macro.asm"

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called


section .text   ; the code parto of file

; zestaw  02
; zadanie 04
;
; Proszę napisać program szukający liczb pierwszych
; w zadanym przedziale.
; brute-force allowed

Function main

    execIO  printf,    "finding primes in given range, need range%c", nl
    execIO  scanf,     "%i%i", long_from, long_to
    execIO  printf,    "finding primes in range [%i, %i]%c", [long_from], [long_to], nl

    mov     rbx, [long_from]
    cmp     rbx, [long_to]
    jng     .validRange
    execIO  printf,     "this is NOT a valid range%c", nl
    return 0;
    .validRange:

    mov     rbx, [long_from]

    .WHILE_do:
        cmp     rbx, [long_to]
        jle     .while_DO
        jmp     .while_do_BREAK
    .while_DO:

        exec    isPrime, rbx
        cmp     rax, true
        jne     .skipNotPrime
        execIO  printf, "%i ", rbx
        .skipNotPrime:
        inc     rbx
        jmp     .WHILE_do
    .while_do_BREAK:

    execIO  printf, "%c", nl

    return;
    


function isPrime ; from zad_01
    push    rbx
    zero    rax, rbx, rcx, rdx

    mov     rax, fArg0
    cmp     rax, 2
    je      .isPrime
    jb      .isNotPrime
    ja      .dunnoYet

    .isPrime:
        pop     rbx
        return  true;

    .isNotPrime:
        pop     rbx
        return  false;

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

    pop     rbx
    return  true;



section .data   ; Initialized data

    long        lowest_prime,   2
    long        the_number,     4
    long        from,           0
    long        to,             0

section .bss    ; UnInitialized data


