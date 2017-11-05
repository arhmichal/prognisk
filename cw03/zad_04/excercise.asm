%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"

section .data   ; Initialized data

section .bss    ; UnInitialized data

section .text   ; the code parto of file

; zestaw  03
; zadanie 04
;
; Dane są dwa ciągi znaków s1 i s2 (poniższe są przykładowe):
; s1="abcdefghijklmnopqrstuvwxyz"
; s2="zyxwvutsrqponmlkjihgfedcba"

; Napisz program, który dla każdej litery ciągu wejściowego znalezionej na pozycji n w ciągu s1 wypisze odpowiadającą jej literę z ciągu s2 na pozycji n, natomiast nie znalezione znaki wypisuje bez zmian.
; Przykład:
; Podaj ciąg znaków...
; ala ma kota
; zoz nz plgz
; Podaj ciąg znaków...
; 123 zoz nz plgz.
; 123 ala ma kota.

Function asm_main
    return;
