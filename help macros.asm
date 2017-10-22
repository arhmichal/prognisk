
; NASM MACRO help

%define param(a,b) ((a)+(a)*(b)) 
; example on 1-line macro with params

%define ala %?  ; %? is macro name as invoced
%define ala %?? ; %?? is macro name as declared
%undef ala

%define NL 10   ; case-sensitive
%idefine NL 10  ; case-insensitive


; xdefine 
%xdefine  isTrue  1 
%xdefine  isFalse isTrue ; 1
%xdefine  isTrue  0 
val1:    db      isFalse ; 1 || not 0 because X_define, not define
%xdefine  isTrue  1 
val2:    db      isFalse ; 1


; [...] construct
     
     mov ax,Foo%[__BITS__]
        ; __BITS__ expands to 32 or 64 - your architecture
        ; [...] allows to expand macro in places it normally won't be expanded
        ; like in other macro names

%define  Quux       13
; equivalent
%xdefine Bar         Quux    ; Expands due to %xdefine 
%define  Bar         %[Quux] ; Expands due to %[...]




; as above but dedicated for numeric constants
%assign NL 10
%iassign NL 10
%assign i i+1   ; can be expression


%defstr test TEST
; is equivalent to
%define test 'TEST'


%deftok test 'TEST'
; is equivalent to
%define test TEST




; macro labels

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

; it appears that i can't make a recurent macro call for unknown param number macros

%macro ala 1+
    mov rax, %0     ; %0 - ilość parametrów
    mov rax, %00    ; %00 - labelka poprzedzająca wywołanie makra (if any), musi być w tej samej linii
%endmacro
; ranges

%macro mpar 1-*     ; range of parameters expected
     db %{3:5}      ; range of parameters extracted
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

; iterate LEFT and RIGHT over all parameters

%macro  multipush 1-* 
  %rep  %0              ; repeat n times
        push    %1 
  %rotate 1             ; shift left by n (right if negative)
                        ; means before %rotate 1
                        ; %1 is %1, but after
                        ; %1 is %2, %2 is %3 ...
  %endrep 
%endmacro
