; UWAGA: Przykład złych praktyk przy wywoływaniu podprogramu


%include "asm_io.inc"

BITS 32
segment .bss
    input1 resd 1
    input2 resd 1


segment .text

global asm_main
asm_main:

mov ebx, input1             ; ładujemy adres input1 do ebx
mov ecx, ret1               ; łądujemy adres etykiety ret1 do ecx - do tej etykiety nastąpi powrót z procedury
jmp short get_int           ; wywołanie procedury get_int

ret1:

mov ebx, input2
mov ecx, $ + 7               ; ecx = adres bieżący + 7
                             ; jest to adres pierwszego bajtu instrukcji do której wracamy z procedury get_int
                                                               ;  musimy znać ilość bajtów ile zajmie na danej maszynie kod maszynowy instrukcji jmp co czyni ten kod nieprzenaszalnym
jmp short get_int

; ...


; subprogram get_int
; Parametry:
; ebx - adres podwójnego słowa,w którym przechowywana będzie wczytana liczba
; ecx - adres instrukcji powrotu
get_int:
call read_int
mov [ebx], eax                  ; zapisujemy dane wejściowe do pamięci
jmp ecx                         ; powrót do procedury wołającej
