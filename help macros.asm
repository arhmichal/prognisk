
; NASM MACRO help

%define param(a,b) ((a)+(a)*(b))
; example on 1-line macro with params
; IMPORTANT you can overload macro defining other macros with the same name
; with different num of params
; BUT a macro with 0 params means there can be no other macros with same name
; and vice-versa

%define ala %?  ; %? is macro name as invoced \\ also for milti-line macros
%define ala %?? ; %?? is macro name as declared \\ also for milti-line macros
%undef ala

%define NL 10   ; case-sensitive
%idefine NL 10  ; case-insensitive




; xdefine - kiedy potrzebujesz wartość z makra z momentu deklaracji, nie expansji
%xdefine  isTrue  1
%xdefine  isFalse isTrue ; 1
%xdefine  isTrue  0
val1:    db      isFalse ; 1 || not 0 because X_define, not define
%xdefine  isTrue  1
val2:    db      isFalse ; 1

; i wersja case-insensitive
%ixdefine  isTrue  1


%define  Quux       13
; equivalent
%xdefine Bar         Quux    ; Expands due to %xdefine
%define  Bar         %[Quux] ; Expands due to %[...]




; [...] construct - to expand a macro where it normally is not expanded
; like in other macro calls
     mov ax,Foo%[__BITS__] ; __BITS__ expands to 32 or 64 - your architecture

; prosta katenacja w makrach - %+
    %define BDA(x)  BDASTART + tBIOSDA. %+ x
    ; called like that
        mov     ax,BDA(COM1addr)
        mov     bx,BDA(COM2addr)
    ; expands into
        mov     ax,BDASTART + tBIOSDA.COM1addr
        mov     bx,BDASTART + tBIOSDA.COM2addr


; preprocesor variables - evaluated once at invocation
%assign NL 10
%iassign NL 10
%assign i i+1   ; can be expression


%defstr test TEST
; is equivalent to
%define test 'TEST'


%deftok test 'TEST'
; is equivalent to
%define test TEST


; string manipulation
%strcat alpha "Alpha: ", '12" screen' ; catenation
    ; produces  'Alpha: 12" screen'
%strcat beta '"foo"\', "'bar'"
    ; produces `"foo"\\'bar'`

    ; The use of commas to separate strings is permitted but optional.

%strlen charcnt 'my string' ; assigns lkength of given string [ here 9 ]
    ; equivalent to
%define sometext 'my string'
%strlen charcnt sometext

; substr
%substr mychar 'xyzw' 1       ; equivalent to %define mychar 'x'
%substr mychar 'xyzw' 2       ; equivalent to %define mychar 'y'
%substr mychar 'xyzw' 3       ; equivalent to %define mychar 'z'
%substr mychar 'xyzw' 2,2     ; equivalent to %define mychar 'yz'
%substr mychar 'xyzw' 2,-1    ; equivalent to %define mychar 'yzw'
%substr mychar 'xyzw' 2,-2    ; equivalent to %define mychar 'yz'



;;; multi-line macros


%macro prologue 1 ; %macro    macro_name    num_of_params
        push    ebp
        mov     ebp,esp
        sub     esp, %1 ; %n is n'th param indexed from 1
%endmacro

; can overload macros, here no restriction for 0-param macro
%macro prologue 0
        push    ebp
        mov     ebp,esp
%endmacro



; you can define macro named like a command
%macro push 2
        push    %1
        push    %2
%endmacro
; this will work but will cause a warninr at compilation
; -w-macro-params ; to disable this warning

; macro-local labels

%macro retz 0
        jnz     %%skip
        ret
    %%skip: ; macro-call-local label
%endmacro   ; different for every CALL

; more params

%macro zero 2+  ; can define macro with
    zero %1     ; ambigous number of params
    zero %2     ; they get lumped together with last one along with separating comas
%endmacro

; a call of a macro  to keep some coma-separated values as ONE PARAM - use { }
writefile [filehandle], {"hello, world",13,10}

; it appears that i can't make a recurent macro call ...

%macro ala 1+
    mov rax, %0     ; %0 - ilość parametrów
    mov rax, %00    ; %00 - labelka poprzedzająca wywołanie makra (if any), musi być w tej samej linii
%endmacro
; ranges

%macro mpar 1-*     ; range of parameters expected
     db %{3:5}      ; range of parameters extracted ; each index can be negative/positive but not 0
     db %{5:3}      ; jak w pythonie ale przedział zamknięty, również odwrucona kolejność
     db %{3:-3}     ; mogą być ujemne - liczone od końca, ostatni == -1
     db %{-1:-1}    ; this trick gives ONLY the last arg
%endmacro

mpar 1,2,3,4,5,6
; expands to 3,4,5 range.
; expands to 5,4,3 range.
; expands to 3,4 range.
; expands to 6 range.


; default param values !!!!

%macro die 0-1 "Painful program death has occurred."
        writefile 2,%1
        mov     ax,0x4c01
        int     0x21
%endmacro

; You can provide extra information to a macro by providing too many default parameters:
%macro quux 1 something
; This will trigger a warning.
; this additional param can be accessed via %a
; it is evaluated on DEFINITION, not on call


; if you don't supply default params, they are defaulted to blanc
; can combine with ambigious param number - the real params number is under %0
%macro die 0-1+ "Painful program death has occurred.",13,10


; %00 will return the label preceeding the macro invocation, if any.
; The label must be on the same line as the macro invocation,
; may be a local label, and need not end in a colon.


; iterate LEFT and RIGHT over all parameters

%macro  multipush 1-*
  %rep  %0              ; repeat n times
        push    %1
    ; %1, %2, %3, %4, %5 ; this original order os changed
  %rotate 1             ; shift left by n (right if negative)
    ;   %2, %3, %4, %5, %1 ; to this order
    ;   %1, %2, %3, %4, %5 ; all accesible by those numbers
  %endrep
%endmacro


; you can reference parameters like %1 or like %{1} for more clearence
; it can help you catenate it with something


;;; condition codes ; a param referenced like %-1 or %+1 i expected to be a CONDITION CODE
; a condition code is a JUMP command but without the J - z, ne, nge, e, etc... OR other conditions
; if NOT a CONDITION CODE is provided, NASM will report an error
%macro do_me 2

    j%+1 %%skip ; condition code expected in %1
    j%-1 %2     ; use INVERTED condition code from %1 - if NZ use Z, if AE use B [NAE], ...

    %%skip

%endmacro


%macro foo 1.nolist ; ".nolist" immidietly after no-of-params means
; NASM will NOT expand the macto in the LIST file only

%unmacro foo 1 ; undefine milti-line macro ; but must specify no-of-args exactly like in definition
; means i can't define macro for 1-3+ params and undef for just 2 params, must for all 1-3+ params



;;; CONDITIONS ;;;

%if <condition> ; condition - numeric value ; zero=false other=true
                ; operators supported in here
                ; = [==], <>[!=], <, <=, >, >=, &&, ||, ^^
                ; eq      neq     l  le  g  ge  and or  xor ; xor special here, 1 if exactly one of the operands is 0
    ; some code which only appears if <condition> is met
%elif <condition2>
    ; only appears if <condition> is not met but <condition2> is
%else
    ; this appears if neither <condition> nor <condition2> was met
%endif

%if         %elif           %else   %endif  ; for each IF exists coresponding ELIF and END
%ifn        %elifn          %else   %endifn ; for each IF SET exists coresponding NOT SET
...

; all IFs
if, ifdef, ifmacro, ifctx, ifidn, ifidni, idif, ifnum, ifstr, iftoken, ifempty, ifenv


; The inverse forms %ifn and %elifn are also supported.
; There are a number of variants of the %if directive.
; Each has its corresponding %elif, %ifn, and %elifn directives;
; for example, the equivalents to the %ifdef directive are %elifdef, %ifndef, and %elifndef.

; you can define 1-line macros via compile command parameters -d like this "-dDEBUG" for DEBUG macro

%ifmacro macroName 1-3+ ; condition check - if macro exists ; above applies - else, elif, end
%ifnmacro macroName 1-3+ ; condition check - if macro not exists ; above applies - else, elif, end

%ifctx ; dunno, see lower - context-local stuff

%ifidn  text1, text2 ; true if texts are identical (white spaces not accounted)
%ifidni text1, text2 ; true if texts are identical (white spaces not accounted) [also case-insensitive]

%ifid   ; true if token is identifier
%ifnum  ; true if token is number
%ifstr  ; true if token is string

%iftoken 1  ; true - 1 is a single token
%iftoken -1 ; false - '-' and '1' are together 2 tokens

%ifempty something ; true if 'something' expands to nothing

%ifenv thing ; true if environment variable referenced by the %!variable directive exists <cokolwiek to znaczy>

; all have coresponding elif, else, end direcives

; loops and breaks in macro
%rep 100 ; loop do 100 times
    %if j > 65535
        %exitrep ; break
    %endif
%endrep ; end of loop






;;; split file

%include "macros.mac"
; include search path is CurrentDir (dir you run NASM from)
; and all specified with -i PATH on command line

%ifndef MACROS_MAC
    %define MACROS_MAC
    ; now define some macros
%endif

; -p FILE in NASM command line includes the FILE even if there is no %include for it

%pathsearch ; dunno
%depend ; dunno

%use package ; includes (like %include) a standard macro package "package"
%use 'package' ; equivalent
; for packages see http://www.nasm.us/doc/nasmdoc5.html







;;; CONTEXT-LOCAL MACRO LABELS !!!!!!!!!!!!!!!!!!!!!!!!
; there are context-stack operattions with optional argument [default=unnamed]
%push contextName   ; creates a new context and puts it on the top of contextStack
                    ; You can have several contexts on the stack with the same name
                    ; AND they can still be distinguished
%pop  contextName   ; pops a context from contextStack and destroys it
                    ; if agr given, must match the name of current context

%$labelName:        ; context-local label
%$labelName         ; reference to context-local label
%$$labelName        ; reference to context-local label
                    ; of ONE LEVEL DEEPER context
%$$$labelName       ; reference to context-local label
                    ; of TWO LEVELS DEEPER context
                    ; ... and so on

; example with repeat-until


%macro repeat 0
    %push   repeat
    %$begin:
%endmacro

%macro until 1
        j%-1    %$begin
    %pop
%endmacro

; context-local single-linne macro
%define %$localmac 3

; rename the top context
%repl newname
; because %pop %push newname destroys context-local labels and macros




; context-top-content if
%ifctx contextName  ; if top context is named contextName
                    ; simmilar to %if, %ifdef, etc..
%ifctx  %elifctx    %else   %endifctx
%ifnctx %elifnctx   %else   %endifnctx



; example of stack usage with if-else-endif

%macro if 1
    %push if
    j%-1  %$ifnot
%endmacro

%macro else 0
  %ifctx if
        %repl   else
        jmp     %$ifend
        %$ifnot:
  %else
        %error  "expected `if' before `else'"
  %endif
%endmacro

%macro endif 0
  %ifctx if
        %$ifnot:
        %pop
  %elifctx      else
        %$ifend:
        %pop
  %else
        %error  "expected `if' or `else' before `endif'"
  %endif
%endmacro



; on-stack parameters
%arg
%stacksize
%local
; TODO - those simplify using on-stack parameters like func arguments and local vars
; see http://www.nasm.us/doc/nasmdoc4.html#section-4.8



; user-defined compilation(assembly) errors
%error content ; reports errors if compilation passed
%warning content ; reports warnings if compilation passed
%fatal content ; reports error and terminates the compilation
               ; use this when any next err/wrn will make no sense



%line nnn[+mmm] [filename] ; dunno


%defstr FOO     %!FOO ; the %!TheName returns value of envvironment variable


; standard available macros


; The single-line macros
__NASM_MAJOR__ ; 0 for "NASM 0.98.32p1"
__NASM_MINOR__ ; 98 for "NASM 0.98.32p1"
__NASM_SUBMINOR__ ; 32 for "NASM 0.98.32p1"
___NASM_PATCHLEVEL__ ; 1 for "NASM 0.98.32p1"

__NASM_SNAPSHOT__ ; defined for automatically generated snapshot releases only

__NASM_VERSION_ID__ ; DWORD integer (not defining a var) being concatenation of the above 4 macros (without SNAPSHOT)
__NASM_VERSION_ID__ ; db 1,32,98,0     for "NASM 0.98.32p1"
__NASM_VERSION_ID__ ; dd 0x00622001    is equivalent value

__NASM_VER__ ; "0.98.32"     for "NASM 0.98.32p1"

__FILE__ ; file name
__LINE__ ; file line number

__BITS__ ; 16, 32, 64 - the OS architecture ?


__OUTPUT_FORMAT__ ; holds the current Output Format, as given by the -f option or NASM's default
                  ;Type nasm -hf for a list.

; For example, in an assembly session started at 42 seconds after midnight on January 1, 2010 in Moscow (timezone UTC+3)
__DATE__            ; "2010-01-01"
__TIME__            ; "00:00:42"
__DATE_NUM__        ; 20100101
__TIME_NUM__        ; 000042
__UTC_DATE__        ; "2009-12-31"
__UTC_TIME__        ; "21:00:42"
__UTC_DATE_NUM__    ; 20091231
__UTC_TIME_NUM__    ; 210042
__POSIX_TIME__      ; 1262293242

__USE_package__ ; defined when a "package" package is included with %use
; eg.
__USE_ALTREG__ ; defined if the altreg is included

__PASS__ ; 0 for run NASM with -M / -MG
__PASS__ ; 1 for preparatory
__PASS__ ; 2 for final assembly
__PASS__ ; 3 in pre-process-only mode
__PASS__ ; DONT USE - for your own sake.


; helps to define structures
STRUC
ENDSTRUC
; dunno details, see http://www.nasm.us/doc/nasmdoc4.html#section-4.11.10

; defines instances of structures
ISTRUC
AT
IEND
; dunno details, see http://www.nasm.us/doc/nasmdoc4.html#section-4.11.11

; elsewhere called "EVEN", helps to allign data/operations
align
alignb
; dunno details, see http://www.nasm.us/doc/nasmdoc4.html#section-4.11.12

; alligns a section
sectalign
; dunno details, see http://www.nasm.us/doc/nasmdoc4.html#section-4.11.13
