%ifndef FUCK_FLOATS_MACRO__ASM
    %define FUCK_FLOATS_MACRO__ASM



%include "fuck_bits.macro.asm" ; for regs



%macro FILDIMM 1
    push %1
    FILD stackElement.cast [resp]
    sub resp, stackElement.size
%endmacro
%define fildimm FILDIMM



%endif
