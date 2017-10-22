%include "../../lib_io64/asm64_io.inc"

%define NL 10

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

global asm_main
asm_main:
    enter 0,0
main:


    mov     rax, 0
    mov     rbx, 0
    mov     rcx, 0
    mov     rdx, 0

    mov     eax, str_gimme_a_number
    call    print_string

    call    read_int
    mov     [int_the_number], eax

    mov     rax, 0
    mov     rbx, 0
    mov     rcx, 0
    mov     rdx, 0


    mov     rdi, str_got_a_number       ; c-string addres with string (format with args if u want ^_^)
    mov     ebx, [int_the_number]
    mov     rsi, rbx                    ; format's 1st arg
    mov     rax, 0                      ; 0 xmm used
    call    printf


    mov     rax, 0
    mov     rbx, 0
    mov     rcx, 0
    mov     rdx, 0

    mov     eax, [int_lowest_prime]
    mov     ecx, [int_the_number]


    cmp     eax, ecx                    ; if (2<=n) // can be a valid prime number
    jbe     f_calculate                 ; calculate
    jmp     f_is_not_a_prime            ; else not_a_prime(); // 0 and 1 are NOT prime


f_calculate:  ; do ... while (n % c > 0)
    dec     ecx                         ; c-- // for first run don't calculate n/n
                                        ; from now on if anything divides n, n is not_a_prime()
    mov     rax, 0
    mov     eax, [int_lowest_prime]
    cmp     eax, ecx                    ; if (2>c) [<=> c==1]
    ja      f_is_a_prime                ; n is_a_prime() // we've beed dividing and decrementing the divider till divider == 1
                                        ;                // so nothing so far divided n, so n is_a_prime()
    mov     rax, 0
    mov     eax, [int_the_number]
    mov     rdx, 0
    div     ecx                         ; else divide :: (n / c)

    cmp     edx, 0                      ; if (n % c == 0) // i'm sure that in this moment (n>c>1)
    je      f_is_not_a_prime            ; something divides n ==> n is_not_a_prime()
    jmp     f_calculate                 ; else calculate()


f_is_not_a_prime:
    mov     rdi, str_is_not_a_prime     ; c-string addres with string (format with args if u want ^_^)
    mov     ebx,  [int_the_number]
    mov     rsi, rbx                    ; format's 1st arg
    mov     rax, 0                      ; 0 xmm used
    call    printf
    jmp     return

f_is_a_prime:
    mov     rdi, str_is_a_prime         ; c-string addres with string (format with args if u want ^_^)
    mov     ebx,  [int_the_number]
    mov     rsi, rbx                    ; format's 1st arg
    mov     rax, 0                      ; 0 xmm used
    call    printf
    jmp     return

return:
    mov rax, 0  ; function's return code
    leave
    ret

; sys_exit:                   ; no longer used because of using lib_io64
;     mov     rax, 60         ; sys_exit()
;     syscall                 ; call;

section .data   ; Initialized data

    int_lowest_prime:       dd      2
    int_the_number:         dd      4
    str_gimme_a_number:     db      "gimme a number for the prime test", NL, 0
    str_got_a_number:       db      "processing number %i for being a prime number", NL, 0
    str_is_a_prime:         db      "number %i is a prime number", NL, 0
    str_is_not_a_prime:     db      "number %i is NOT a prime number", NL, 0

section .bss    ; UnInitialized data
