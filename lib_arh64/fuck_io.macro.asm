%include "fuck_functions.macro.asm" ; for exec
%include "lib_arh.macro.asm" ; for zero

%macro StackAllign16 0
    mov r12, rsp    ; r10 - example register not changed by function call
    and rsp, -16    ; FFFFFFFFFFFFFFF0
%endmacro
%macro StackUnAllign16 0
    mov rsp, r12    ; r10 - the same example register as above
%endmacro



%macro execIO 1-7
    StackAllign16
    zero rax
    exec %{1:-1}
    StackUnAllign16
%endmacro

