%ifndef FUCK_IO_MACRO__ASM
    %define FUCK_IO_MACRO__ASM



; extern  printf  ; the C function, to be called
; extern  scanf   ; the C function, to be called



%include "fuck_bits.macro.asm" ; for regs
%include "fuck_functions.macro.asm" ; for exec
%include "lib_arh.macro.asm" ; for zero

%if __BITS__ == 32
    %macro StackAllign16 0
        mov resi, resp    ; esi - example register not changed by function call
        and resp, -16    ; FFFFFFFFFFFFFFF0
    %endmacro
    %macro StackUnAllign16 0
        mov resp, resi    ; r12 - the same example register as above
    %endmacro
%elif __BITS__ == 64
    %macro StackAllign16 0
        mov r12, resp    ; r12 - example register not changed by function call
        and resp, -16    ; FFFFFFFFFFFFFFF0
    %endmacro
    %macro StackUnAllign16 0
        mov rsp, r12    ; r12 - the same example register as above
    %endmacro
%endif


%macro execIO 1-7
    StackAllign16
    zero reax
    exec %{1:-1}
    StackUnAllign16
%endmacro

%macro execIO_safe 1-7
    push reax, recx, redx
    execIO %{1:-1}
    pop  reax, recx, redx
%endmacro

%if __BITS__ == 64
    %macro execIO_paranoid_safe 1-7
        push rax, rcx, rdx, rsi, rdi, r8, r9, r10, r11, r12
        execIO %{1:-1}
        pop  rax, rcx, rdx, rsi, rdi, r8, r9, r10, r11, r12
    %endmacro
%endif




%endif
