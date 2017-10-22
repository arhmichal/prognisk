%include "../../lib_io64/asm64_io.inc"

%define NL 10

section .text   ; the code parto of file

; zestaw  02
; zadanie 04
;
; Proszę napisać program szukający liczb pierwszych
; w zadanym przedziale.
; brute-force allowed

; global _start   ; makes it public
; _start:         ; the main() of assembler ; no longer used because of using lib_io64

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

global asm_main
asm_main:
    enter 0,0
main:

    init_and_get_a_number:
    call    zeroReg

    mov     eax, str_gimme_a_number
    call    print_string

    call    read_int
    mov     [int_a], eax

    call    read_int
    mov     [int_b], eax

    call    zeroReg

    mov     rdi, str_got_a_number       ; c-string addres with string (format with args if u want ^_^)
    mov     esi, [int_a]                ; format's 1st arg
    mov     edx, [int_b]                ; format's 1st arg
    mov     rax, 0                      ; 0 xmm used
    call    printf



    validate_range:
    call zeroReg
    mov     eax, [int_a]
    mov     ebx, [int_b]
    cmp     eax, ebx
    ja      invalid_range_exception     ; if (a > b) invalid_range_exception();
    init_and_get_a_range_done:



    call    zeroReg
    mov     eax, [int_a]
    mov     ebx, [int_b]
    mov     ecx, eax

    DO_while:
    mov     rax, rcx
    call    print_if_prime
    inc     rcx
    cmp     rcx, rbx
    ja      while_break
    jmp     DO_while                    ; while(range.x <= range.y);
    while_break:

    jmp     return




print_if_prime:
    push    rbx
    push    rcx

    mov     rbx, rax
    call    test_for_prime

    if:     ; if (test_for_prime())
    cmp     eax, 0
    jz      if_true
    jmp     else
    if_true:
    mov     rax, rbx
    call    println_int
    jmp     end_if
    else:
    jmp     end_if
    end_if:

    pop     rcx
    pop     rbx
    ret


invalid_range_exception:
    mov     rdi, str_invalid_range      ; c-string addres with string (format with args if u want ^_^)
    mov     rax, 0                      ; 0 xmm used
    call    printf
    jmp     return


test_for_prime:
    enter   0, 0
    mov     rcx, rax
    mov     rbx, rax
    
    check_if_below_2:
    cmp     eax, 2
    jae     prime_do_while              ; if (n >= 2) prime_do_while();
    jmp     n_is_not_a_prime            ; else not_a_prime(); // 0 and 1 are NOT prime
    jmp return

prime_do_while:  ; do ... while (n % c > 0)
    dec     ecx                         ; c-- // for first run don't calculate n/n
                                        ; from now on if anything divides n, n is not_a_prime()
    in_while_check_if_below_2:
    cmp     ecx, 2
    jb      n_is_a_prime                ; if (c < 2) is_a_prime()
    ; else: still can divide by a number >= 2 so i do

    mov     eax, ebx                    ; a = n
    mov     rdx, 0
    div     ecx                         ; a / c

    cmp     edx, 0
    je      n_is_not_a_prime            ; if (n % c == 0) something divides n ==> n is_not_a_prime()
    jmp     prime_do_while              ; else do...WHILE(...)

n_is_not_a_prime:
    mov     rax, 1                      ; return false
    jmp     return

n_is_a_prime:
    mov     rax, 0                      ; return true
    jmp     return








; support functions

return:
    leave
    ret

zeroReg:
    mov     rax, 0
    mov     rbx, 0
    mov     rcx, 0
    mov     rdx, 0
    mov     rdi, 0
    mov     rsi, 0
    ret

pushReg:
    push    rax
    push    rbx
    push    rcx
    push    rdx
    push    rdi
    push    rsi
    ret

popReg:
    pop     rsi
    pop     rdi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rax
    ret

; sys_exit:                   ; no longer used because of using lib_io64
;     mov     rax, 60         ; sys_exit()
;     syscall                 ; call;





section .data   ; Initialized data

    str_prime:              db      "a prime", NL, 0
    str_not_prime:          db      "not a prime", NL, 0
    str_gimme_a_number:     db      "finding primes in given range, need a range", NL, 0
    str_got_a_number:       db      "finding primes in [%i, %i]", NL, 0
    str_invalid_range:      db      "the range is invalid", NL, 0
    int_a:                  dd      0
    int_b:                  dd      0



    ; int_n:                  dd      0
    ; str_gimme_a_number:     db      "gimme a number for the prime test", NL, 0
    ; str_got_a_number:       db      "number %i is ", 0
    ; int_gcd:                dd      0
    


    int_lowest_prime:       dd      2
    int_the_number:         dd      4
    str_is_a_prime:         db      "number %i is a prime number", NL, 0
    str_is_not_a_prime:     db      "number %i is NOT a prime number", NL, 0


section .bss    ; UnInitialized data





