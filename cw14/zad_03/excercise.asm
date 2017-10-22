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

; zestaw  14
; zadanie 03
;
; Napisz klasę Przedział o końcach typu double.
; Posługując się wstawkami asemblerowymi zaimplementuj operatory + i - : dodający i odejmujący poprawnie dwa przedziały. 

; W ścisłych obliczeniach arytmetycznych zamiast liczb zmiennoprzecinkowych wykorzystuje się przedziały,
; określając dla nich zwykłe operacje arytmetyczne w ten sposób, że wynikiem działania jest możliwie najmniejszy przedział, 
; który zawiera wszystkie możliwe wyniki pomiędzy elementami pierwszego i drugiego przedziału.
; Np. dla dodawania [a,b] + [c,d] = [a+c, b+d].
; Niestety liczby a+c i b+d mogą nie być reprezentowalne na komputerze, dlatego aby otrzymać własność  zawierania musimy obliczyć a+c zaokrąglając w dół, a b+d zaokrąglając w górę. Można tego dokonać ustawiając przed dodawaniem odpowiednie flagi FPU tzw control word. 
; Niestety z poziomu C++ nie mamy dostępu do tych flag i musimy to zrobić z poziomu asemblera.

; Do zmiany control word służą instrukcje 
; fstcw mem   - zapisuje w pamięci control word
; fldcw mem   - wczytuje z pamięci control word

; Za zaokrąglanie są odpowiedzialne bity 11 i 12  
; 00 - zaokrąglanie do najbliższej 
; 01 - zaokrąglanie w dół (wartość 0x0400)
; 10 - zaokrąglanie w górę (wartość 0x800)

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

