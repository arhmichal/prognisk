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

; zestaw  09
; zadanie 01
;
; Proszę napisać funkcję asemblerową diff, która korzysta z operacji SSE w celu wyliczenia numerycznej pochodnej z tablicy jednowymiarowej T zmiennych 8-bitowych (np.piksele obrazu). 
; W praktyce jest to różnica sąsiadujących pikseli. 
; Funkcja DIFF jest trochę ogólniejsza, dostaje na wejściu dwa wiersze W1 i W2 o długości n.
; Pochodną DIFF należy wyliczać według wzoru:

; DIFF[i]=W2[i]-W1[i]

; Sposób użycia funkcji diff przedstawiono na Listingu 3.

; Listing 3 Opakowanie dla funkcji diff

; #include <stdio.h>

; #define N 100

; // na wyjściu out[i] = wiersz1[i] - wiersz2[i]
; extern "C" void diff(char *out,char *wiersz1,char *wiersz2,int n);

; int main(void)
; {
;     char Tablica[N+1],DIFF[N];
;     int i;

;     Tablica[0]=1;
;     for(i=1;i<=N;i++) Tablica[i]=Tablica[i-1]+i;

;     diff(DIFF, Tablica+1, Tablica, N);

;     for(i=0;i<N;i++) printf("%d ",DIFF[i]);
;     printf("\n");
    
; }
; // OUT: 1 2 3 4 5 6 7 8 ....

; Aby uniknąć przepełnień dobrze jest stosować odejmowanie z  nasyceniem PSUBSB.

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

