%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

section .data   ; Initialized data
    
    long    max, 0
    long    num, 0

section .bss    ; UnInitialized data

section .text   ; the code part of file

; zestaw  03
; zadanie 01
;
; Zaimplementować program wczytujący liczby całkowite ze znakiem
; i odkładający je na stos aż do wczytania 0.
; Następnie wczytujemy dodatkową liczbę całkowitą A.
; Na ekran należy wypisać
; ilość wczytanych liczb mniejszych od A. 

 Function main

    zero    rax, rbx, rcx, rdx
    mov     r13, rsp

    execIO  printf, "give an array of integers, terminated with 0%c", nl

    .DO_while:
        execIO  scanf, "%il", long_num
    .do_WHILE:
        cmp     qword [long_num], 0
        je      .do_while_BREAK
        push    qword [long_num]
        jmp     .DO_while
    .do_while_BREAK:

    execIO  printf, "give a number ... "
    execIO  scanf, "%il", long_max
    execIO  printf, "amount of numbers x < %i is ", [long_max]

nextPartWriteAmount:

    mov     rbx, 0
    .WHILE_do:
        cmp     rsp, r13
        jne     .while_DO
        jmp     .while_do_BREAK
    .while_DO:

        pop     rdx
        cmp     [long_max], rdx
        jle     .skipIncrement
        inc     rbx
        .skipIncrement:
        jmp     .WHILE_do
    .while_do_BREAK:

    execIO  printf, "%i%c", rbx, nl

    return;
