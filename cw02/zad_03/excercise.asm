%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"

section .text   ; the code parto of file

; zestaw  02
; zadanie 03
;
; Proszę napisać program szukający
; najmniejszej wspólnej wielokrotności dwóch liczb
; wczytanych z klawiatury.

; global _start   ; makes it public
; _start:         ; the main() of assembler ; no longer used because of using lib_io64

  global asm_main
function asm_main

    execIO  printf,    "calculating Least Common Multiple, need two numbers%c", nl
    execIO  scanf,     "%i%i", long_a, long_b
    execIO  printf,    "LCM(%i, %i) = ", [long_a], [long_b]

    exec    lcm, [long_a], [long_b]
    ; exec    gcd, [long_a], [long_b]
    mov     [long_gcd], rax
    execIO  printf,    "%i%c", [long_gcd], nl

    return;


function lcm
    cmp     fArg0, 0
    jz      .ret_0
    cmp     fArg1, 0
    jz      .ret_0
    jmp     .non_0

    .ret_0:
    return 0

    .non_0:
    push    fArg0, fArg1
    exec    gcd, fArg0, fArg1
    pop     fArg0, fArg1
    mov     rbx, rax
    divR    fArg0, rbx
    mul     fArg1
    
    return rax;


function gcd
    cmp     fArg0, 0
    jz      .ret_b
    cmp     fArg1, 0
    jz      .ret_a
    jmp     .if

    .ret_b:
    return fArg1
    .ret_a:
    return fArg0

    .if:
        cmp     fArg0, fArg1
        jne     .if_true
        jmp     .else
    .if_true:

        cmp     fArg0, fArg1
        ja      .reassignA
        jb      .reassignB
        je      .recurentCall

        .reassignA:
        divR    fArg0, fArg1
        mov     fArg0, rdx
        jmp     .recurentCall

        .reassignB:
        divR    fArg1, fArg0
        mov     fArg1, rdx
        jmp     .recurentCall

        .recurentCall:
        exec    gcd, fArg0, fArg1
        return  rax;

        jmp     .end_if
    .else:
        return  fArg0;
        jmp     .end_if
    .end_if:

    return 0;

; int NWD(int a, int b)
; {
;    if(a!=b)
;      return NWD(
        ; a>b ? a%b : a,
        ; b>a ? b%a : b);
;    return a;
; }

section .data   ; Initialized data

    long                    a,      0
    long                    b,      0
    long                    gcd,    0

section .bss    ; UnInitialized data
