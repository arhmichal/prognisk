; początek sekcji kodu.
section .text

; zestaw  01
; zadanie 03
;
; Napisz program który otwiera plik do zapisu (jeżeli go nie ma to go tworzy)
; wpisuje do niego tekst np. Twoje imię i nazwisko
; następnie go zamyka

; public: main();
global _start

; początek main()'a
_start:

    mov     rax, 2              ; file_descriptor = sys_open(fileName, operation_mode, access_mode)
    mov     rdi, string_fileName; fileName = "FileName".c-str()
    mov     rsi, 101o           ; operation_mode == (CREATE==0100 | WRITE=01) `octa
    mov     rdx, 644o           ; access_mode == chmod 644
    syscall                     ; call;
    mov     [fd], eax           ; fd = file_descriptor (or error_code)


    mov     rax, 1              ; write = sys_write(out, str, len)
    mov     rdi, [fd]           ; out = std::cout
    mov     rsi, string_me      ; str = &string_hi
    mov     rdx, string_me_length    ; len = string_hi.length()
    syscall                     ; call;
    ; mov     [len], eax          ; len = write (or error_code)


    mov     rax, 3          ; sys_close(file_descriptor) ; close_file
    mov     rdi, [fd]       ; file_descriptor = fd
    syscall                 ; call;
    ; mov     [err], eax      ; err = error_code


dbg_exit:
    mov     rax, 60         ; sys_exit()
    syscall                 ; call;


; początek sekcji danych.
section .data
    string_me               db      "Michał Kawiecki - ARH"
    string_me_length        equ     $ - string_me
    string_fileName         db      "TheFile", 0
    string_fileName_length  equ     $ - string_fileName
    fd                      dq      0

section .bss
