; początek sekcji kodu.
section .text

; zestaw  01
; zadanie 01
;
; Skompiluj przykładowe przykłady, 
; zmodyfikuj je w ten sposób aby 
;   - pytały o imię, 
;   - wczytywały je z klawiatury
;   - wypisywały spersonalizowane przywitanie.

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
    mov     rsi, string_name        ; buffor = &buffor
    mov     rdx, 32                 ; size = amount_to_read
    syscall                         ; call;
    mov     [string_name_length], rax      ; len = read (or error_code)


    mov     rax, 1                  ; write = sys_write(out, str, len)
    mov     rdi, 1                  ; out = std::cout
    mov     rsi, string_hiThere     ; str = &string_hi
    mov     rdx, string_hiThere_length   ; len = string_hi.length()
    syscall                         ; call;
    ; mov     [len], eax              ; len = write (or error_code)


    mov     rax, 1                  ; write = sys_write(out, str, len)
    mov     rdi, 1                  ; out = std::cout
    mov     rsi, string_name        ; str = &string_hi
    mov     rdx, [string_name_length]   ; len = string_hi.length()
    syscall                         ; call;
    ; mov     [len], eax              ; len = write (or error_code)

    mov     rax, 60                 ; sys_exit()
    syscall                         ; call;


; początek sekcji danych.
section .data
    string_hi           db      "Hi, state your name", NL, 0
    string_hi_length    equ     $ - string_hi
    string_hiThere           db      "Hi, ", 0
    string_hiThere_length    equ     $ - string_hiThere

section .bss
    string_name         resb    32
    string_name_length  resq    1
