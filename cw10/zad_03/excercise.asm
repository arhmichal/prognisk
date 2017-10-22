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

; zestaw  10
; zadanie 03
;
; Zaimplementować filtry uwzględniające otoczenie tak jak opisano tutaj.
; W skrócie: dla każdego piksela liczymy średnią ważoną w jego otoczeniu 3x3 tzn. liczymy sumę pikseli z otoczenia przemnożonych przez odpowiednią wagę z macierzy weight, a następnie dzielimy przez sumę wag. 
; Należy użyć funkcji wektorowych operujących na floatach.
; Przykład użycia 

; #include <iostream>
; #include <cmath>
; using namespace std;

; // width powinien dzielic sie przez 4
; const int width = 300, height = 168;
    
; void filtr(int imageWidth, int imageHeight, float image[height][width], 
;            float weight[3][3], float result[height][width]){
;   //....
; }
    
; int main(void)
; {
;     const int headerLength = 122; // 64; //sizeof(BMPHEAD);
;     char header[headerLength];
;     float data[3][height][width];
;     float result[3][height][width];
;     float weight[3][3]= {{0, -2, 0} ,{ -2, 11, -2}, {0, -2, 0}};
;     int i,j,k;
;     FILE *file;

;     file=fopen("pigeon.bmp","rb");
;     if(!file) { std::cerr << " Error opening file !"; exit(1); }
;     fread(header, headerLength, 1, file);
;     for(i=0;i<height;i++)
;         for(j=0;j<width;j++)
;            for(k=0; k<3; ++k)
;             data[k][i][j]=fgetc(file);
;     fclose(file);

;     for(i=0;i<3;i++)
;         filtr(width, height, data[i], weight, result[i]);
    
;     file=fopen("result.bmp","wb");
;     fwrite(header, headerLength, 1, file);
;     for(i=0;i<height;i++)
;       for(j=0;j<width;j++)
;         for(k=0; k<3; ++k)
;           fputc((unsigned char)result[k][i][j],file);
;     fclose(file);
            
; }


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

