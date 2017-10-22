%define NL 10

section .data   ; Initialized data

    f_ln                    db      NL, 0
    f_int                   db      "%li", 0
    f_int_ln                db      "%li", NL, 0
    f_str                   db      "%s", 0
    f_str_ln                db      "%s", NL, 0

section .bss    ; UnInitialized data

section .data   ; arrays

section .text   ; the code parto of file

; zestaw  04
; zadanie 04
;

; Napisać moduł asemblerowy implementujący funkcję minmax  wyliczającą minimalny i maksymalny spośród argumentów funkcji. Pierwszym argumentem funkcji jest liczba całkowita N>0, po której następuje N argumentów całkowitych (patrz uwaga poniżej).   
; Wyniki mają być zwracane jako struktura MM.

; typedef struct{
;     int max;
;     int min;
; } MM;

; MM minmax( int N, ...);

; int main(){
;    MM wynik = minmax(7, 1, -2, 4 , 90, 4, -11, 101);
;    printf("min = %d, max = %d \n", wynik.min, wynik.max);
;    return 0;
; }
; Aplikacja ma być złożona z dwóch modułów w C (operacje IO, wywołanie funkcji ) i ASM (wyznaczenie minimum i maksimum).
; Uwaga: Sposób zwracania zależy od systemu operacyjnego i wersji kompilatora:
; Linux: Jako pierwszy argument funkcji minmax zostanie przekazany wskaźnik na obiekt typu MM, który należy uzupełnić.
; Windows, starsze gcc pod linuxem: Struktura MM mieści się w sumie rejestrów EDX:EAX i tam powinna być zwrócona.

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

; macros - cause they are like functions, easier, convinient
;          AND CAN BE OVERLOADED !!!!

%macro sys_exit 0           ; no longer used because of using lib_io64
    mov     rax, 60         ; sys_exit()
    syscall                 ; call;
%endmacro

%macro print 1
    mov     rdi, %1
    mov     rax, 0
    call    printf
%endmacro

%macro print 2
    mov     rdi, %1
    mov     rsi, %2
    mov     rax, 0
    call    printf
%endmacro

%macro print 3
    mov     rdi, %1
    mov     rsi, %2
    mov     rdx, %3
    mov     rax, 0
    call    printf
%endmacro

%macro scan 2
    mov     rdi, %1
    mov     rsi, %2
    mov     rax, 0
    call    scanf
%endmacro

%macro return 0
    leave
    ret 0;
%endmacro

%macro return 1
    leave
    ret %1;
%endmacro

; global _start   ; makes it public
; _start:         ; the main() of assembler ; no longer used because of using lib_io64

global asm_main
asm_main:
    enter 0,0
    call zeroReg
void_main:

    return;





; support functions

zeroReg:
    mov     rax, 0
    mov     rbx, 0
    mov     rcx, 0
    mov     rdx, 0
    mov     rdi, 0
    mov     rsi, 0
    ret;

pushReg:
    enter   0,0
    push    rax
    push    rbx
    push    rcx
    push    rdx
    push    rdi
    push    rsi
    return;

popReg:
    enter   0,0
    pop     rsi
    pop     rdi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rax
    return;

