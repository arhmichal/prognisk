%ifndef LIB_ARH_MACRO__ASM
    %define LIB_ARH_MACRO__ASM



%include "fuck_system_consts.macro.asm"



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



%idefine byteInBits 8
%idefine byte.size 1
%idefine word.size 2
%idefine int.size 4
%idefine long.size 8

%define _8b byte
%define _16b word
%define _32b dword
%define _64b qword

%macro bajt 2+
    byte_%1: db %2
%endmacro
%macro word 2+
    word_%1: dw %2
%endmacro
%macro int 2+
    int_%1: dd %2
%endmacro
%macro long 2+
    long_%1: dq %2
%endmacro
%macro cstring 2+
    str_%1: db %2, 0
%endmacro
%macro charstring 2+
    str_%1: db %2
    str_%1.len: equ $ - str_%1
%endmacro
%macro string 2+
    str_%1: db %2, 0
    str_%1.len: equ $ - str_%1
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



%macro defArray 3 ; name, elem.size, ptr
    %define %1(i) [%3 + %2 * i]
%endmacro



%ifdef never_assemble_this

%macro tmpName 0
%endmacro

%endif

%endif
