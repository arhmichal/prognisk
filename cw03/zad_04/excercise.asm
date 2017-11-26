%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"
%include "fuck_logic.macro.asm"

; %define DEBUG_ON

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

section .data   ; Initialized data
    string s1, "abcdefghijklmnopqrstuvwxyz"
    string s2, "zyxwvutsrqponmlkjihgfedcba"

    %define maxStringSize 256
    returnString: times maxStringSize db 0

section .bss    ; UnInitialized data

section .text   ; the code parto of file

; zestaw  03
; zadanie 04
;
; Dane są dwa ciągi znaków s1 i s2 (poniższe są przykładowe):
; s1="abcdefghijklmnopqrstuvwxyz"
; s2="zyxwvutsrqponmlkjihgfedcba"

; Napisz program, który dla każdej litery ciągu wejściowego
; znalezionej na pozycji n w ciągu s1
; wypisze odpowiadającą jej literę z ciągu s2 na pozycji n,
; natomiast nie znalezione znaki wypisuje bez zmian.
;
; Przykład:
; Podaj ciąg znaków...
; ala ma kota
; zoz nz plgz
; Podaj ciąg znaków...
; 123 zoz nz plgz.
; 123 ala ma kota.

Function main

%ifdef DEBUG_ON
    execIO printf, '%d/ asm_main() s1 = "%s"%c', __LINE__, str_s1, nl
    execIO printf, '%d/ asm_main() s2 = "%s"%c', __LINE__, str_s2, nl
%endif

    exec encode, str_s1, str_s2, "ala ma kota"
    exec encode, str_s1, str_s2, "123 ala ma kota"

    return;



function encode;(str from, str to, int from, str toEncode) return string encoded
    push rbx

    zero rcx ; this block init-zero both strings
    while rcx, l, maxStringSize
        mov _8b [returnString+rcx], 0
        inc rcx
    endwhile

    execIO_paranoid_safe printf, '"%s"%c', fArg2, nl

    defArray toEncode, byte.size, fArg2
    defArray encoded, byte.size, returnString

    zero rbx
    while _8b toEncode(rbx), ne, 0
            zero rax
            mov al, toEncode(rbx)
            mov r8, rax
        push fArg2
        exec encodeOneChar, fArg0, fArg1, r8
        pop fArg2
            mov _8b encoded(rbx), al
        inc rbx
    endwhile

    execIO_paranoid_safe printf, '"%s"%c', returnString, nl

    pop  rbx
    return returnString;



function encodeOneChar;(string from, string to, char c) return char
    push rbx

    mov rbx, fArg2
    defArray strFrom, byte.size, fArg0
    defArray strTo, byte.size, fArg1

    zero rax
    while _8b strFrom(rax), ne, 0
        if strFrom(rax), e, fArg2_8L
            mov rbx, strTo(rax)
        endif
        inc rax
    endwhile

    mov rax, rbx
    pop  rbx
    return rax;
