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
; zadanie 03
;
; Korzystając z instrukcji SSE proszę napisać procedurę zmniejszającą dwukrotnie rozmiar bitmapy przedstawionej na Rys. 1. Każdy stopień szarości piksela OUT(i,j) wynikowej bitmapy ma być średnią z czterech odpowiednich stopni szarości pikseli bitmapy wejściowej IN według wzoru: 

; OUT(i,j) = (IN(2*i,2*j) + IN(2*i +1,2*j) + IN(2*i,2*j + 1) + IN(2*i + 1,2*j + 1))/4

; Na Listingu 5 przedstawiony jest kod opakowania dla procedury skalującej bitmapę wraz z prototypem i sposobem użycia tej funkcji.

; #include <stdio.h>

; void scaleSSE(float *,float *,int);

; int main(void)
; {
;     float data[400][400],dum[200][200];
;     unsigned char header[1078];
;     unsigned char ch;
;     int N=400,HL=1078;
;     int i,j;
;     FILE *strm;

;     strm=fopen("circle.bmp","rb");
;         for(i=0;i<HL;i++) header[i]=fgetc(strm);
;         for(i=0;i<N;i++)
;         for(j=0;j<N;j++)
;             data[i][j]=(float)fgetc(strm);
;     fclose(strm);
    
;     for(i=0;i<N/2;i++) scaleSSE(dum[i],data[2*i],N);
    
;     header[4]=0;
;     header[3]=160;
;     header[2]=118;
    
;     header[18]=200;
;     header[19]=0;
;     header[22]=200;
;     header[23]=0;
    
;     strm=fopen("dum.bmp","wb");
;         for(i=0;i<HL;i++) fputc(header[i],strm);
;         for(i=0;i<N/2;i++)
;         for(j=0;j<N/2;j++)
;             fputc((unsigned char)dum[i][j],strm);
;     fclose(strm);
           
; }

; Informacje o wielkości bitmapy są zapisane w modyfikowanych bajtach nagłówka. W bajtach od 2 poczynając zakodowany jest rozmiar bitmapy w bajtach (równy wysokość*szerokość zaokrąglona do najbliższej liczby podzielnej przez 4 + ilość bajtów nagłówka). W bajtach od 18 poczynając zakodowane są wysokość i szerokość bitmapy.



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

