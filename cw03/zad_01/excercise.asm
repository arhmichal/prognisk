%define NL 10

section .data   ; Initialized data

    f_ln                    db      NL, 0
    f_int                   db      "%li", 0
    f_int_ln                db      "%li", NL, 0
    f_str                   db      "%s", 0
    f_str_ln                db      "%s", NL, 0

    str_gimme_an_array:     db      "provide list of numbers terminated with 0", NL, 0
    str_gimme_a_number:     db      "gimme a number", NL, 0
    str_got_a_number:       db      "there are %i numbers on the list, lesser then %i", NL, 0

    long_count:             dq      0
    long_mid:               dq      0

    long_tmp:               dq      0

section .bss    ; UnInitialized data

section .data   ; arrays

section .text   ; the code parto of file

; zestaw  03
; zadanie 01
;
; Zaimplementować program wczytujący liczby całkowite ze znakiem
; i odkładający je na stos aż do wczytania 0.
; Następnie wczytujemy dodatkową liczbę całkowitą A.
; Na ekran należy wypisać
; ilość wczytanych liczb mniejszych od A. 

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

; macros - cause they are like functions, easier, convinient
;          AND CAN BE OVERLOADED !!!!

%macro sys_exit 0           ; no longer used because of using lib_io64
    mov     rax, 60         ; sys_exit()
    syscall                 ; call;
%endmacro

%macro print 1
    mov     rdi, %1
    mov     rax, 0
    call    printf
%endmacro

%macro print 2
    mov     rdi, %1
    mov     rsi, %2
    mov     rax, 0
    call    printf
%endmacro

%macro print 3
    mov     rdi, %1
    mov     rsi, %2
    mov     rdx, %3
    mov     rax, 0
    call    printf
%endmacro

%macro scan 2
    mov     rdi, %1
    mov     rsi, %2
    mov     rax, 0
    call    scanf
%endmacro

%macro return 0
    leave
    ret 0;
%endmacro

%macro return 1
    leave
    ret %1;
%endmacro

; global _start   ; makes it public
; _start:         ; the main() of assembler ; no longer used because of using lib_io64

global asm_main
asm_main:
    enter 0,0
    call zeroReg
void_main:

    print   str_gimme_an_array
    call    read_numbers_and_push_until_0
    mov     rbx, rsp                        ; secure current rsp
    mov     rsp, rax                        ; this is stack pointer to last read number
    print   str_gimme_a_number
    scan    f_int,  long_mid
    mov     rax, rsp                        ; this is stack pointer to last read number
    call    count_lesserThan_mid
    mov     rsp, rbx                        ; restore current rsp
    print   str_got_a_number,   [long_count],   [long_mid]

    return;



read_numbers_and_push_until_0:
    enter   0,0
    push    0

    .DO_while:
        scan    f_int,  long_tmp
        push    qword [long_tmp]
    .do_WHILE:
        cmp     qword [long_tmp], 0
        jz      .do_while_break
        jmp     .DO_while
    .do_while_break:
    mov     rax, rsp
    return;



count_lesserThan_mid:
    enter   0,0
    mov     qword [long_count], 0
    push    rdx

    mov     rbx, rsp                        ; secure current rsp
    mov     rsp, rax                        ; this is stack pointer to last read number
    pop     rdx                         ; the last read number is delimiter = 0
    pop     rdx                         ; first non-zero number from input or 0 if no numbers read
    .WHILE_do:
        cmp     rdx, 0
        jne     .while_DO
        jmp     .while_do_BREAK
    .while_DO:
        .if:
            cmp     rdx, qword [long_mid]
            jl      .if_true
            jmp     .else
        .if_true:
            mov     rcx, [long_count]
            inc     rcx
            mov     [long_count], rcx
            jmp     .end_if
        .else:
            jmp     .end_if
        .end_if:

        pop     rdx
        jmp     .WHILE_do
    .while_do_BREAK:

    mov     rsp, rbx                        ; restore current rsp
    pop     rdx
    return;


; support functions

zeroReg:
    mov     rax, 0
    mov     rbx, 0
    mov     rcx, 0
    mov     rdx, 0
    mov     rdi, 0
    mov     rsi, 0
    ret;

pushReg:
    enter   0,0
    push    rax
    push    rbx
    push    rcx
    push    rdx
    push    rdi
    push    rsi
    return;

popReg:
    enter   0,0
    pop     rsi
    pop     rdi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rax
    return;

