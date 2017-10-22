%include "../../lib_io64/asm64_io.inc"

%define NL 10

section .text   ; the code parto of file

; zestaw  02
; zadanie 03
;
; Proszę napisać program szukający
; najmniejszej wspólnej wielokrotności dwóch liczb
; wczytanych z klawiatury.

; global _start   ; makes it public
; _start:         ; the main() of assembler ; no longer used because of using lib_io64

extern  printf  ; the C function, to be called

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
    init_and_get_a_number_done:

    check_for_zeros:
    call    zeroReg
    mov     eax, [int_a]
    mov     ebx, [int_b]

    cmp     eax, 0
    je      print_a

    cmp     ebx, 0
    je      print_b

    jmp     got_non_zero_numbers

    print_b:
    mov     eax, [int_b]
    call    println_int
    jmp     return

    print_a:
    mov     eax, [int_a]
    call    println_int
    jmp     return

got_non_zero_numbers:
    call    zeroReg
    mov     eax, [int_a]
    mov     ebx, [int_b]

    call    gcd
    mov     [int_gcd], eax
    call    zeroReg
    mov     eax, [int_a]
    mov     ebx, [int_b]
    mov     ecx, [int_gcd]

    div     ecx
    mul     ebx

    call    println_int
    jmp     return

; int NWD(int a, int b)
; {
;    if(a!=b)
;      return NWD(
        ; a>b ? a-b : a,
        ; b>a ? b-a : b);
;    return a;
; }

gcd:                        ; Greatest Common Divider
    enter   0, 0
    mov     rcx, 0
    mov     rdx, 0

    cmp     eax, ebx
    je      nwd_return      ; if (a == b) return a

    cmp     eax, ebx
    ja      sub_for_a
    jb      sub_for_b

    sub_for_a:
    sub     eax, ebx
    jmp     sub_done

    sub_for_b:
    sub     ebx, eax
    jmp     sub_done

    sub_done:
    call    gcd             ; recursive call

    nwd_return:             ; return a
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

    int_a:                  dd      0
    int_b:                  dd      0
    int_gcd:                dd      0
    str_gimme_a_number:     db      "calculating Least Common Multiple, need two numbers", NL, 0
    str_got_a_number:       db      "LCM(%i, %i) = ", 0

section .bss    ; UnInitialized data
