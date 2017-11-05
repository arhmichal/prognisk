%ifndef FUCK_FUNCTIONS_MACRO__ASM
    %define FUCK_FUNCTIONS_MACRO__ASM


%include "lib_arh.macro.asm"


%define fArg0 RDI
%define fArg1 RSI
%define fArg2 RDX
%define fArg3 RCX
%define fArg4 R8
%define fArg5 R9


%macro fCountFloat 0-1 0
    mov RAX, %1
%endmacro

%macro fSetArg0 1
    mov fArg0, %1
%endmacro
%macro fSetArg1 1
    mov fArg1, %1
%endmacro
%macro fSetArg2 1
    mov fArg2, %1
%endmacro
%macro fSetArg3 1
    mov fArg3, %1
%endmacro
%macro fSetArg4 1
    mov fArg4, %1
%endmacro
%macro fSetArg5 1
    mov fArg5, %1
%endmacro


%macro setArgOrString 2
    %ifstr %2
        jmp %%afterStr
        %%str: db %2, 0
        %%afterStr:
        %1 %%str
    %else
        %1 %2
    %endif
%endmacro


%macro f_SetIntArgs 0
%endmacro
%macro f_SetIntArgs 1
    f_SetIntArgs
    setArgOrString fSetArg0, %1
%endmacro
%macro f_SetIntArgs 2
    f_SetIntArgs %{1:-2}
    setArgOrString fSetArg1, %2
%endmacro
%macro f_SetIntArgs 3
    f_SetIntArgs %{1:-2}
    setArgOrString fSetArg2, %3
%endmacro
%macro f_SetIntArgs 4
    f_SetIntArgs %{1:-2}
    setArgOrString fSetArg3, %4
%endmacro
%macro f_SetIntArgs 5
    f_SetIntArgs %{1:-2}
    setArgOrString fSetArg4, %5
%endmacro
%macro f_SetIntArgs 6
    f_SetIntArgs %{1:-2}
    setArgOrString fSetArg5, %6
%endmacro
%macro fSetIntArgs 0-6
    f_SetIntArgs %{1:-1}
%endmacro


%macro exec 1
    call %1
%endmacro
%macro exec 2-7
    fSetIntArgs %{2:-1}
    call %1
%endmacro


%macro return 0-1 0
    mov     rax, %1
    leave
    ret
%endmacro
%macro return 2
    mov     rax, %1
    leave
    ret     %2
%endmacro


%macro function 1
%1: enter 0, 0
%endmacro
%macro Function 1
  global %1
function %1
%endmacro


%endif
