%ifndef LIB_ARH_MACRO__ASM
    %define LIB_ARH_MACRO__ASM



%include "fuck_bits.macro.asm" ; for regs
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

%macro pushRev 1-*
    %rep %0
        %rotate -1
        push %1
    %endrep
%endmacro

%macro popRev 1-*
    %rep %0
        pop %1
        %rotate 1
    %endrep
%endmacro



%idefine bitsInByte 8

%idefine byte.size 1
%idefine char.size 1
%idefine word.size 2
%idefine short.size 2
%idefine int.size 4
%idefine float.size 4
%idefine long.size 8
%idefine double.size 8
%idefine longdouble.size 10

%define _8b byte
%idefine byte.cast byte
%idefine char.cast byte
%define _16b word
%idefine word.cast word
%idefine short.cast word
%define _32b dword
%idefine int.cast dword
%idefine float.cast dword
%define _64b qword
%idefine long.cast qword
%idefine double.cast qword

%if __BITS__ == 32
    %define stackElement.size int.size
    %define stack.size int.size
    %define stackElement.cast int.cast
    %define stack.cast int.cast
%elif __BITS__ == 64
    %define stackElement.size long.size
    %define stack.size long.size
    %define stackElement.cast long.cast
    %define stack.cast long.cast
%endif

%macro bajt 2+
    byte_%1: db %2
%endmacro
%macro char 2+
    char_%1: db %2
%endmacro
%macro word 2+
    word_%1: dw %2
%endmacro
%macro short 2+
    word_%1: dw %2
%endmacro
%macro int 2+
    int_%1: dd %2
%endmacro
%macro float 2+
    float_%1: dd %2
%endmacro
%macro long 2+
    long_%1: dq %2
%endmacro
%macro double 2+
    double_%1: dq %2
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


; TODO ; remove/replace devE and divR
%macro divE 2
    zero    eax, edx
    mov     eax, %1
    div     %2
%endmacro
%if __BITS__ == 64
    %macro divR 2
        zero    rax, rdx
        mov     rax, %1
        div     %2
    %endmacro
%endif



%macro defArray 3 ; name, elem.size, ptr
    %define %1(i) [%3 + %2 * i]
%endmacro



%define movVia(reg) mov_via_helping_reg reg, 
%macro mov_via_helping_reg 3; pass_thrue_reg, to, from
    mov %1, %3
    mov %2, %1
%endmacro



%endif
