%ifndef LIB_ARH_MACRO__ASM
    %define LIB_ARH_MACRO__ASM


%include "fuck_system.macro.asm"
%include "fuck_functions.macro.asm"


%idefine NL 10  ; \n
%idefine CR 13  ; \r

%idefine true  0x1
%idefine false 0x0


%macro zero 1-*
    %rep %0
        xor %1, %1
        %rotate 1
    %endrep
%endmacro

%macro push 2-*
    %rep %0
        push %1
        %rotate 1
    %endrep
%endmacro

%macro pop 2-*
    %rep %0
        %rotate -1
        pop %1
    %endrep
%endmacro



%macro Bajt 2
    byte_%1: db %2
%endmacro
%macro int 2
    int_%1: dd %2
%endmacro
%macro long 2
    long_%1: dq %2
%endmacro
%macro cstring 2+
    str_%1: db %2,0
%endmacro
%macro string 2+
    str_%1: db %2
    str_%1_len: equ $ - str_%1
%endmacro



%macro move 2
    zero %1
    mov  %1, %2
%endmacro



%macro divE 2
    zero    eax, edx
    mov     eax, %1
    div     %2
%endmacro
%macro divR 2
    zero    rax, rdx
    mov     rax, %1
    div     %2
%endmacro





%macro tmpName 0
%endmacro

%endif
