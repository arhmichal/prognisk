%include "../../lib_io64/asm64_io.inc"

%define NL 10

section .text   ; the code parto of file

; zestaw  02
; zadanie 01
;
; Proszę napisać program wypisujący rozkład zadanej liczby na czynniki pierwsze.
; Można wypisywać posługując się asm_io lub printf.
; Np. dla liczby 60 wyjście powinno zawierać:
; 2 2 3 5

; global _start   ; makes it public
; _start:         ; the main() of assembler ; no longer used because of using lib_io64

extern  printf  ; the C function, to be called

global asm_main
asm_main:
    enter 0,0
main:

    call    zeroReg

    mov     eax, str_gimme_a_number
    call    print_string

    call    read_int
    mov     [int_the_number], eax

    call    zeroReg

    mov     rdi, str_got_a_number       ; c-string addres with string (format with args if u want ^_^)
    mov     esi, [int_the_number]       ; format's 1st arg
    mov     rax, 0                      ; 0 xmm used
    call    printf


    mov     ecx, 1                      ; factor = 1
    mov     rax, 0
    mov     ebx, [int_the_number]
    while_condition:
    mov     eax, [int_lowest_prime]
    cmp     eax, ebx                    ; if (n < 2) [n=0 or n=1] pre_check_else()
    jbe     f_process                   ; therefore while (n >= 2) f_process()

        ; this section is made this way to format output properly
        ; it only happens when input-number is 0 or 1
        ; or when we divide the number down to 0 or 1 so it doesn't make sense to continue
        cmp     ecx, 1                  ; c is the factor
        ja      skip_printing           ; if (c > 1) skip_print()
        pre_check_else:                 ; if (n <= 2) print the number
        mov     eax, ebx
        push    rcx
        call    print_int               ; print breaks rcx - therefore push/pop rcx
        pop     rcx
        skip_printing:
        call    print_nl
        mov     rax, 0                      ; function's return code
        jmp     return                      ; end program here

    f_process:

    while_body:
    inc     ecx

    mov     rax, rbx                    ; the number in rax
    push    rdx
    push    rcx
    push    rax
    call f_divide
    mov     rbx, rax                    ; new (divided) the number
    pop     rax
    pop     rcx
    pop     rdx

    jmp     while_condition

    mov rax, 0  ; function's return code
    jmp     return

f_divide:                               ; keeps dividing the number by a factor until it can't any more
    enter 0,0

;     mov     rax, [ebp + 16] ; = the number ; already in there
;     mov     rcx, [ebp + 24] ; = the factor ; already in there
    mov     rbx, 0
    mov     ebx, eax                    ; dividing may change eax to unwanted number


    divide_do_while:        ; DO_while(...)
    mov     edx, 0
    div     ecx             ; eax = d:a / c 
                            ; edx = d:a % c
    cmp     edx, 0          ; if (% != 0) return;
    jnz     divide_end      ; if (% != 0) return;

    mov     ebx, eax

    mov     rdi, std_a_factor
    mov     rsi, rcx
    mov     rax,  0
    push    rcx
    call    printf
    pop     rcx
    mov     eax, ebx
    jmp     divide_do_while ; do_WHILE(...)

    divide_end:

    mov     eax, ebx        ; function's return value - THE NUMBER !! after all divisions
    jmp     return

; support functions

return:
    leave
    ret

zeroReg:
    enter 0,0
    mov     rax, 0
    mov     rbx, 0
    mov     rcx, 0
    mov     rdx, 0
    mov     rdi, 0
    mov     rsi, 0
    jmp   return

pushReg:
    enter 0,0
    push    rax
    push    rbx
    push    rcx
    push    rdx
    push    rdi
    push    rsi
    jmp   return

popReg:
    enter 0,0
    pop     rsi
    pop     rdi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rax
    jmp   return

; sys_exit:                   ; no longer used because of using lib_io64
;     mov     rax, 60         ; sys_exit()
;     syscall                 ; call;

section .data   ; Initialized data

    int_lowest_prime:       dd      2
    int_the_number:         dd      0
    str_gimme_a_number:     db      "gimme a number for the factorization", NL, 0
    str_got_a_number:       db      "processing number %i for factorization", NL, 0
    std_a_factor:           db      "%i ", 0

section .bss    ; UnInitialized data
