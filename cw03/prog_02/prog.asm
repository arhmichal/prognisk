%include "asm64_io.inc"

BITS 64
segment .bss
    input1 resd 1
    input2 resd 1


segment .text
global asm_main
asm_main:

;...

mov  ebx, input1             ; ładujemy adres input1 do ebx
call get_int                 ; wywołanie procedury get_int

mov ebx, input2
call get_int

ret

; subprogram get_int
; Parametry:
; ebx - adres podwójnego słowa,gdzie zapisana zostanie wczytana liczba

get_int:
push rax                ; odkładamy rax na stos bo read_int go modyfikuje
call read_int
mov [ebx], eax          ; zapisujemy dane wejściowe do pamięci
pop  rax                ; odtwarzamy rax
ret                     ; powrót do procedury wołającej
