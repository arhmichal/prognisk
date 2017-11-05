%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"
%include "fuck_logic.macro.asm"

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

section .data   ; Initialized data
    %define maxStringSize 40
    returnString: times maxStringSize db 0
    reversedString: times maxStringSize db 0
    char minus, '-'

section .bss    ; UnInitialized data
    
section .text   ; the code parto of file

; zestaw  03
; zadanie 03
;
; Napisać funkcję przekształcającą dany łańcuch tekstowy (zakończony zerem)
; na liczbę całkowitą
; oraz drugą funkcję przekształcającą liczbę całkowitą (ze znakiem)
; na łańcuch tekstowy zakończony zerem
; ( np. dla liczby 123 wynikiem powinno być "123",0). 
; Program powinien prezentować możliwości tych funkcji.

Function asm_main

    exec itos, -138
    exec itos, 11
    exec itos, 0
    exec itos, 0321654987
    exec itos, -321654987
    exec stoi, "-1224"
    exec stoi, "321"
    exec stoi, "0"
    exec stoi, "0321654987"
    exec stoi, "-321654987"
    
    return;



function itos;(int number) ; assume integer
    push rbx
    mov r11, fArg0

    zero rcx ; this block init-zero both strings
    while rcx, l, maxStringSize
        mov _8b [returnString+rcx], 0
        mov _8b [reversedString+rcx], 0
        inc rcx
    endwhile

    mov rbx, 1 ; sign of the number
    mov rcx, 0 ; iterator over string
    defArray textNumber, byte.size, returnString
    defArray textReversed, byte.size, reversedString

    cmp fArg0, 0 ; special case '0'
        jne .non.zero
        mov textReversed(rcx), _8b '0'
        je  .end.this
    .non.zero:

    if fArg0, l, 0 ; remember and insert the sign
        mov rbx, -1
        imul fArg0, -1
    endif

    zero rax, rdx
    mov  rax, fArg0

    while rax, g, 0 ; gather REVERSED string
        mov r10, 10
        zero rdx
        div r10
        add rdx, '0'
        mov textReversed(rcx), rdx
        inc rcx
    endwhile

    if rbx, l, 0 ; put a sign if needed
        mov r9, 0
        add r9, '-'
        mov textReversed(rcx), r9
        inc rcx
    endif

    dec rcx ; reverse string
    zero rbx
    while rcx, ge, 0
        mov al, textReversed(rcx)
        mov textNumber(rbx), al
        inc rbx
        dec rcx
    endwhile

    .end.this:
    execIO_paranoid_safe printf, 'itos(%d) = "%s"%c', r11, returnString, nl
    pop  rbx
    return returnString;



function stoi;(std::string text) ; assume integer
    push rbx
    mov r11, fArg0

    mov r8, fArg0
    zero rax, rbx, rcx, rdx, rdi
    defArray text, byte.size, r8

    mov rbx, 1 ; sign of the number
    add dl, '-'
    if text(0), e, dl ; remember the sign
        mov rbx, -1
        inc rcx
    endif

    while _8b text(rcx), ne, 0 ; agregate
        mov  al, text(rcx)
        sub  al, '0'
        imul rdi, 10
        add  rdi, rax
        inc  rcx
    endwhile

    imul rdi, rbx ; insert the sign

    mov r9, rdi
    execIO_paranoid_safe printf, 'stoi("%s") = %d%c', r11, r9, nl

    pop  rbx
    return rdi;
