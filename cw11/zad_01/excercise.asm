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

; zestaw  11
; zadanie 01
;
; Napisz w asemblerze funkcje 
; void  minmax(int n, int * tab, int & max, int & min);
; która dla tablicy tab o rozmiarze n znajduje maksimum i minimum. 

; Należy  napisać przynajmniej 3 wersje tej funkcji w tym:

;     jedną w języku C++,
;     dwie wersje w asemblerze. 

; Funkcję w asemblerze należy tak napisać aby zawierała nie więcej niż jeden skok warunkowy.
; Należy też napisać wersję wykorzystującą instrukcje CMOVXX.

; Porównaj  prędkość różnych wersji funkcji używając programu
; #include <cstdio>
; #include <time.h>
; using namespace std;
; extern "C" void minmax(int n, int * tab, int * max, int * min);

; int main(){
;    const int rozmiar = 100000;
;    const int liczba_powtorzen = 10000; 
;    int tab[rozmiar] = {1, 3, 3, -65, 3, 123, 4, 32, 342, 22, 11, 32, 44, 12, 324, 43}; 
;    tab[rozmiar-1] = -1000;
;    int min, max;
;    clock_t start, stop;
;    start = clock();
;    for(int i=0; i<liczba_powtorzen; i++){
;       minmax(rozmiar, tab, &max, &min);
;    }
;    printf("min = %d    max = %d\n", min, max); 
;    stop = clock();
;    printf("\n time = %f  ( %d cykli)", (stop - start)*1.0/CLOCKS_PER_SEC, (stop - start));
;    return 0;
; }

; Wypróbuj też kod gdy tablica jest wypełniana losowymi liczbami.

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

