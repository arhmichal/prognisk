%include "../../lib_io64/asm64_io.inc"
%include "../../lib_arh64/lib_arh.macro.asm"

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
extern  scanf   ; the C function, to be called

global asm_main
asm_main:
    enter 0,0
main:

    zero    rax, rbx, rcx, rdx, rdi, rsi

    execIO printf,    str_gimme_a_number
    execIO scanf,     str_pattern_int, int_the_number
    execIO printf,    str_got_a_number, [int_the_number]

    zero    rax, rbx, rcx, rdx, rdi, rsi

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
        return                          ; end program here

    f_process:

    while_body:
    inc     ecx

    mov     rax, rbx                    ; the number in rax
    push    rax, rcx, rdx
    call f_divide
    mov     rbx, rax                    ; new (divided) the number
    pop     rax, rcx, rdx       ; the number in rax

    jmp     while_condition

    return;

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

    push    rcx
    execIO printf,    str_a_factor, rcx
    pop     rcx
    mov     eax, ebx
    jmp     divide_do_while ; do_WHILE(...)

    divide_end:
    
    return  rbx        ; function's return value - THE NUMBER !! after all divisions

; support functions

section .data   ; Initialized data

    int         lowest_prime,       2
    int         the_number,         0
    cstring     gimme_a_number,     "gimme a number for the factorization", nl
    cstring     got_a_number,       "processing number %i for factorization", nl
    cstring     a_factor,           "%i "
    cstring     pattern_int,        "%i"

section .bss    ; UnInitialized data
