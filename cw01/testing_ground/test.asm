%include "lib_arh.macro.asm"
%include "fuck_io.macro.asm"
%include "fuck_logic.macro.asm"

; %define DEBUG_ON

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

section .data   ; Initialized data

section .bss    ; UnInitialized data

section .text   ; the code parto of file

Function main

    execIO printf, "hello dah wodddd! %d%c", __BITS__, nl

    return;
