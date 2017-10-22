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
; zadanie 02
;
; Korzystając z instrukcji SSE proszę napisać procedurę wyliczającą amplitudę gradientu obrazu - 8-bitowej bitmapy. Na Listingu 4 przedstawiony jest kod z instrukcjami pozwalającymi czytać i pisać do bitmapy 256-kolorowej. Dla polepszenia dokładności obliczeń gradientu, zarówno dane wejściowe jak i wyjściowe są typu float. Na Listingu 4 przedstawiono również prototyp funkcji liczącej gradient. Gradient GRAD(i,j) w pikselu (i,j) liczony jest według wzoru:

; GRAD(i,j)=sqrt((DATA(i+1,j)-DATA(i-1,j))2+(DATA(i,j+1)-DATA(i,j-1))2)

; Listing 4 Opakowanie asemblerowej funkcji liczącej gradient obrazu
; #include <stdio.h>
; #include <math.h>

; //Na wyjściu: grad[i] = sqrt( (data[i+1] - data[i-1])^2 + (data[i+N] - data[i-N])^2) 
; // dla i=0,1,...,N-2 
; extern "C" void gradientSSE(float *grad, float * data, int N);

; int main(void)
; {
;     float data[400][400],header[1078];
;     unsigned char ch;
;     float grad[400][400],sq;
;     int N=400,HL=1078;
;     int i,j;
;     FILE *strm;

;     strm=fopen("circle.bmp","rb");
;         for(i=0;i<HL;i++) header[i]=fgetc(strm);
;         for(i=0;i<N;i++)
;         for(j=0;j<N;j++)
;             data[i][j]=(float)fgetc(strm);
;     fclose(strm);

;     for(i=1;i<N-1;i++)
;         gradientSSE(grad[i]+1,data[i]+1,N);
    
;     strm=fopen("dum.bmp","wb");
;         for(i=0;i<HL;i++) fputc(header[i],strm);
;         for(i=0;i<N;i++)
;         for(j=0;j<N;j++)
;             fputc((unsigned char)grad[i][j],strm);
;     fclose(strm);
            
; }

; Przykładowe obrazy wejściowy (Rys. 1) i wyjściowy (Rys. 2) przedstawiono poniżej.
; Uwaga: Obrazek należy otworzyć w nowym oknie a następnie zapisać! Bezpośrednie zapisanie może powodować błędny format pliku.














;    Rys. 1 Obraz wejściowy                Rys. 2  Obraz wyjściowy

; UWAGA: Zaproponowana w zadaniu procedura liczenia gradientu z obrazu nie ma szczególnie dobrych własności i raczej nie jest wykorzystywana w praktyce. Filtry gradientowe można jednak zaimplementować, korzystając z analogicznych metod, jak rozważane w zadaniu.

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

