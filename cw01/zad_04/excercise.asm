; początek sekcji kodu.
section .text

; zestaw  01
; zadanie 04
;
; Napisz program, który odczyta czas systemowy
; i wypisze aktualna godzinę. 

; public: main();
global _start

; początek main()'a
_start:


    mov     rax, 201        ; sys_time()
    mov     rdi, long_sec   ; buffor [= NULL] = &result_copy
    syscall                 ; call;
    ; mov     [sec], eax      ; sec = sec_since_01_01_1970_dec_by_1

    mov     edx, 0          ; zero-out - just for safety
    mov     ecx, 10         ; ..:..:.X
    div     ecx             ; a = a/c ; d = a%c
    add     edx, '0'        ; itos(edx)
    mov     [string_date + 7], dl


    mov     edx, 0          ; zero-out - just for safety
    mov     ecx, 6          ; ..:..:Xx
    div     ecx             ; a = a/c ; d = a%c
    add     edx, '0'        ; itos(edx)
    mov     [string_date + 6], dl


    mov     edx, 0          ; zero-out - just for safety
    mov     ecx, 10         ; ..:.X:xx
    div     ecx             ; a = a/c ; d = a%c
    add     edx, '0'        ; itos(edx)
    mov     [string_date + 4], dl


    mov     edx, 0          ; zero-out - just for safety
    mov     ecx, 6          ; ..:Xx:xx
    div     ecx             ; a = a/c ; d = a%c
    add     edx, '0'        ; itos(edx)
    mov     [string_date + 3], dl



    mov     edx, 0          ; zero-out - just for safety
    mov     ecx, 24         ; take only HOURS
    div     ecx             ; a = a/c ; d = a%c
    mov     eax, edx        ; to have only time, trunk out the days, months, etc.


; IMPORTANT ! ! ! ! ! IMPORTANT ! ! ! ! ! IMPORTANT ! ! ! ! ! IMPORTANT ! ! ! ! !
    inc     eax             ; polska => strefa czasowa +1
    inc     eax             ; czas letni => kolejne +1
; IMPORTANT ! ! ! ! ! IMPORTANT ! ! ! ! ! IMPORTANT ! ! ! ! ! IMPORTANT ! ! ! ! !


    mov     edx, 0          ; zero-out - just for safety
    mov     ecx, 10         ; .X:xx:xx
    div     ecx             ; a = a/c ; d = a%c
    add     edx, '0'        ; itos(edx)
    mov     [string_date + 1], dl


    mov     edx, 0          ; zero-out - just for safety
    mov     ecx, 3          ; Xx:xx:xx
    div     ecx             ; a = a/c ; d = a%c
    add     edx, '0'        ; itos(edx)
    mov     [string_date + 0], dl



    mov     rax, 1                  ; write = sys_write(out, str, len)
    mov     rdi, 1                  ; out = std::cout
    mov     rsi, string_date        ; str = &string_hi
    mov     rdx, string_date_len    ; len = string_hi.length()
    syscall                         ; call;
    ; mov     [len], eax              ; len = write (or error_code)


dbg_exit:
    mov     rax, 60         ; sys_exit()
    syscall                 ; call;


; początek sekcji danych.
section .data
    string_date         db      "XX:XX:XX", 0ah
    string_date_len     equ     $ - string_date
    long_sec            dd      0

section .bss
