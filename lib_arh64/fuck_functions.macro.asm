%ifndef FUCK_FUNCTIONS_MACRO__ASM
    %define FUCK_FUNCTIONS_MACRO__ASM


%include "lib_arh.macro.asm"


%define fArg0 RDI
%define fArg1 RSI
%define fArg2 RDX
%define fArg3 RCX
%define fArg4 R8
%define fArg5 R9

%define fArg0_64 RDI
%define fArg1_64 RSI
%define fArg2_64 RDX
%define fArg3_64 RCX
%define fArg4_64 R8
%define fArg5_64 R9

%define fArg0_32 EDI
%define fArg1_32 ESI
%define fArg2_32 EDX
%define fArg3_32 ECX

%define fArg0_16 DI
%define fArg1_16 SI
%define fArg2_16 DX
%define fArg3_16 CX

%define fArg0_8H DH
%define fArg1_8H SH
%define fArg2_8H DH
%define fArg3_8H CH

%define fArg0_8L DL
%define fArg1_8L SL
%define fArg2_8L DL
%define fArg3_8L CL


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
    %pop
    mov     rax, %1
    leave
    ret
%endmacro
%macro return 2
    %pop
    mov     rax, %1
    leave
    ret     %2
%endmacro


%macro function 1
    %push %1
%1: enter 0, 0
%endmacro
%macro Function 1
  global %1
function %1
%endmacro


%endif
