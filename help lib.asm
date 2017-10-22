; this is a help-lib for easy copy-paste;

%include "../../lib_io64/asm64_io.inc"
%include "../../lib_arh64/lib_arh.macro.asm"

section .text   ; the code parto of file

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

global _start   ; makes it public
_start:         ; the main() of assembler



global asm_main
asm_main:
    enter 0,0
main:
    ; ...
return;


golbal_label:   ; widziana wszędzie | jak bardzo wszędzie?
.local_label:   ; widziana ... tak naprawde jest to część etykiety
; kompletna etykieta wygląda tak "golbal_label.local_label"
; gdzie global to ostatnia napotkana przed nią globalna etykieta


    ; flow controll
    ; flow controll


    .if:
        cmp     XXX, YYY
        jz      .if_true
        jmp     .else
    .if_true:
        jmp     .end_if
    .else:
        jmp     .end_if
    .end_if:



    .DO_while:
    .do_WHILE:
        cmp     XXX, YYY
        jXX     .do_while_BREAK
        jmp     .DO_while
    .do_while_BREAK:



    .WHILE_do:
        cmp     XXX, YYY
        jXX     .while_DO
        jmp     .while_do_BREAK
    .while_DO:
        jmp     .WHILE_do
    .while_do_BREAK:



    ; flow controll
    ; flow controll



section .data   ; Initialized data
    string_hi           db      "Hi, state your name", 0 , 0ah, 0
    string_hi_length    equ     $ - string_hi
    string_hiThere           db      "Hi, ", 0
    string_hiThere_length    equ     $ - string_hiThere

section .bss    ; UnInitialized data, also arrays
    string_name         resb    32
    string_name_length  resq    1

section .data   ; arrays
    array01     dd  1, 2, 3, 4
    array02     dw  1, 2, 3, 4, 5, 'x', "qwe", NL, 0
    array_0x03  times 10    1
                times 132   0



;;; TODO weź zrób z tego czytelną tabelkę ...

    ; alloc defines the section to be one which is loaded into memory when the program is run. noalloc defines it to be one which is not, such as an informational or comment section.
    ; exec defines the section to be one which should have execute permission when the program is run. noexec defines it as one which should not.
    ; write defines the section to be one which should be writable when the program is run. nowrite defines it as one which should not.
    ; progbits defines the section to be one with explicit contents stored in the object file: an ordinary code or data section, for example, nobits defines the section to be one with no explicit contents given, such as a BSS section.
    ; align=, used with a trailing number as in obj, gives the alignment requirements of the section.
    ; tls defines the section to be one which contains thread local variables. 

section .text       ; progbits  alloc   exec    nowrite  align=16 
section .rodata     ; progbits  alloc   noexec  nowrite  align=4 
section .lrodata    ; progbits  alloc   noexec  nowrite  align=4 
section .data       ; progbits  alloc   noexec  write    align=4 
section .ldata      ; progbits  alloc   noexec  write    align=4 
section .bss        ; nobits    alloc   noexec  write    align=4 
section .lbss       ; nobits    alloc   noexec  write    align=4 
section .tdata      ; progbits  alloc   noexec  write    align=4    tls 
section .tbss       ; nobits    alloc   noexec  write    align=4    tls 
section .comment    ; progbits  noalloc noexec  nowrite  align=1 
section other       ; progbits  alloc   noexec  nowrite  align=1
