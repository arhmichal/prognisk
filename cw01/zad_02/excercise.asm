; początek sekcji kodu.
section .text

; zestaw  01
; zadanie 02
;
; Napisz program, który wczyta dwie liczby (jedno cyfrowe)
; doda je do siebie
; wyświetli wynik.

%define NL 10

; public: main();
global _start

; początek main()'a
_start:

    mov     rax, 1                  ; write = sys_write(out, str, len)
    mov     rdi, 1                  ; out = std::cout
    mov     rsi, string_hi          ; str = &string_hi
    mov     rdx, string_hi_length   ; len = string_hi.length()
    syscall                         ; call;
    ; mov     [len], eax              ; len = write (or error_code)


    mov     rax, 0                  ; read = sys_read(in, buffor, size)
    mov     rdi, 0                  ; in = std::cin
    mov     rsi, int_a              ; buffor = &buffor
    mov     rdx, 2                  ; size = amount_to_read ; one number and enter
    syscall                         ; call;
    ; mov     [string_name_length], rax      ; len = read (or error_code)

    mov     rax, 0                  ; zeruj-out the register, just in case
    mov     al, [int_a]
    mov     [string_full], al       ; write it into final string
    sub     al, '0'                 ; stoi(int_a)
    mov     [int_a], al


    mov     rax, 0                  ; read = sys_read(in, buffor, size)
    mov     rdi, 0                  ; in = std::cin
    mov     rsi, int_b              ; buffor = &buffor
    mov     rdx, 2                  ; size = amount_to_read ; one number and enter
    syscall                         ; call;
    ; mov     [string_name_length], rax      ; len = read (or error_code)

    mov     rax, 0                  ; zeruj-out the register, just in case
    mov     al, [int_b]
    mov     [string_full + 4], al   ; write it into final string
    sub     al, '0'                 ; stoi(int_b)
    mov     [int_b], al

    mov     rax, 0
    mov     al, [int_a]
    add     al, [int_b]
    mov     [int_sum], al

    mov     cl, 10
    div     cl
    add     al, '0'
    mov     [string_full + 8], al   ; write it into final string
    add     ah, '0'
    mov     [string_full + 9], ah   ; write it into final string

    mov     rax, 1                  ; write = sys_write(out, str, len)
    mov     rdi, 1                  ; out = std::cout
    mov     rsi, string_full        ; str = &string_full
    mov     rdx, string_full_length ; len = string_full.length()
    syscall                         ; call;
    ; mov     [len], eax              ; len = write (or error_code)

dbg_exit:
    mov     rax, 60         ; sys_exit()
    syscall                 ; call;


; początek sekcji danych.
section .data
    int_a               db      0
    int_b               db      0
    int_sum             db      0
    string_plus         db      " + ", 0
    string_plus_length  equ     $ - string_plus
    string_eq           db      " = ", 0
    string_eq_length    equ     $ - string_eq
    string_hi           db      "hi, i'll add two numbers", NL, 0
    string_hi_length    equ     $ - string_hi
    string_full         db      "a + b =  s", NL, 0
    string_full_length  equ     $ - string_full

section .bss
