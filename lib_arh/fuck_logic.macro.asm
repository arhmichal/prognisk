%ifndef FUCK_LOGIC_MACRO__ASM
    %define FUCK_LOGIC_MACRO__ASM

; %include "lib_arh.macro.asm"


%macro if 3
    %push   if
        cmp     %1, %3
        j%+2    %$ifTrue
        jmp     %$ifFalse
        %$ifTrue:
%endmacro
%macro else 0
    %ifctx if
        %repl   else
        jmp     %$endif
        %$ifFalse
    %else
        %error "expected `if` before `else`"
    %endif
%endmacro
%macro endif 0
    %ifctx if
        %$ifFalse:
        %pop if
    %elifctx else
        %$endif:
        %pop else
    %else
        %error "expected `if` or `else` before `endif`"
    %endif
%endmacro

%macro while 3
    %push   while
        %$while:
        cmp     %1, %3
        j%+2    %$ifTrue
        jmp     %$endWhile
        %$ifTrue:
%endmacro
%macro endwhile 0
    %ifctx while
        jmp     %$while
        %$endWhile:
        %pop while
    %else
        %error "expected `while` before `endwhile`"
    %endif
%endmacro

%macro do 0
    %push dowhile
        %$ifTrue:
%endmacro
%macro dowhile 3
    %ifctx dowhile
            %$while:
            cmp     %1, %3
            j%+2    %$ifTrue
            %$enddowhile:
        %pop dowhile
    %else
        %error "expected `do` before `dowhile`"
    %endif
%endmacro

%macro break 0
    %ifctx while
        jmp     %$endWhile
    %elifctx dowhile
        jmp     %$enddowhile
    %else
        %error "expected `while` or `dowhile` before `break`"
    %endif
%endmacro


%endif
