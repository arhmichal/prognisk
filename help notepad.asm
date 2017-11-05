; this is a help-notepad for easy braim-memory-refresh

; |---------------32---------------|-------16-------|----8---|----8---|
; |----------------4---------------|--------2-------|----1---|----1---|
; |--------------------------------|----------------|---AH---|---AL---|
; |--------------RAX---------------|----------------AX----------------|

;;; rozmiary danych i dane zainiclalizowane

; db _ resb => 08b = 1B char | byte         byte
; dw _ resw => 16b = 2B short               word
; dd _ resd => 32b = 4B int | float         dword [double word]
; dq _ resq => 64b = 8B double              qword [quadruple word]

; do _ reso => 128b = 16B                   oword [octuple word]

; dt _ rest => 80b = 10B long long float    
; dy _ resy => ?b = ?B                      

;;; dane zainiclalizowane - sekcja .DATA

    label:      d_    values                ; declare initialized DATA

                db    0x55                  ; just the byte 0x55 
                db    0x55,0x56,0x57        ; three bytes in succession 
                db    'a',0x55              ; character constants are OK 
                db    'hello',13,10,'$'     ; so are string constants 
                dw    0x1234                ; 0x34 0x12 
                dw    'a'                   ; 0x61 0x00 (it's just a number) 
                dw    'ab'                  ; 0x61 0x62 (character constant) 
                dw    'abc'                 ; 0x61 0x62 0x63 0x00 (string) 
                dd    0x12345678            ; 0x78 0x56 0x34 0x12 
                dd    1.234567e20           ; floating-point constant 
                dq    0x123456789abcdef0    ; eight byte constant 
                dq    1.234567e20           ; double-precision float 
                dt    1.234567e20           ; extended-precision float

    message:    db      'hello, world'      ; an array of bytes holding the string

    msglen:     equ     $-message           ; EQU is evaluated at compilation - calculate NEXT
    msglen:     equ     $-message           ; $ == begining of THIS line == end of PREV line == this label
    msglen:     equ     $-message           ; $$ == begining of THIS SECTION == end of PREV SECTION
    msglen:     equ     $-message           ; this is equal to the `message.length()`

    zerobuf:    times 64    db 0            ; TIMES is evaluated at compilation - execute NEXT n times
    zerobuf:    times 64    db 0            ; this is `var zerobuf` sizeof(zerobuf) == (64*bd) with values `0` each


;;; dane NIE-zainiclalizowane - sekcja .BSS

    label:          res_    size            ; reserve SIZE times the DATA_SIZE for uninitialized DATA

    buffer:         resb    64              ; reserve 64 bytes 
    wordvar:        resw    1               ; reserve a word 
    realarray       resq    10              ; array of ten reals 
    ymmval:         resy    1               ; one YMM register

;;; dane - corner cases

    L6 dd 1A92h            ; double word initialized to hex 1A92
    mov [L6], 1               ; próba zapisu 1 do L6 - niepoprawna, zwróci błąd operation size not specified
    mov dword [L6], 1         ; próba zapisu 1 do L6 - poprawna


;;; rejestry

[RE] AX accumulator                 ; handy use-me space
[RE] BX base                        ; usually keeps indirect address or array index
[RE] CX counter                     ; loop counter
[RE] DX data                        ; data

[RE] SI source index [SIL]          ; pointer to source.begin for strings/arrays
[RE] DI destination index [DIL]     ; pointer to destination.begin for strings/arrays

[RE] BP base-of-stack pointer
[RE] SP stack-current-top pointer
[RE] IP instruction pointer         ; pointer to next-to-execute-function
[RE] FLAGS holds flags related to the last operation
    CF carry flag - flaga przeniesienia / add?
    OF overflow flag - flaga przepełnienia / mul?
    SF sign flag - flaga znaku / sub?
    ZF zero flag - flaga zera / dec?
    IF interrupt flag - flaga przerwań / call?
    PF parity flag - flaga parzystości / div?
    DF direction flag - flaga kierunku / ?


; segment registers
CS code section pointer
DS data section pointer
SS stack section pointer
ES *additional section-pointer
FS *additional section-pointer
GS *additional section-pointer

R8
R9
R10
R11
R12
R13
R14
R15


;;; operacje jakie poznałem
;;; tak, to będzie przejebanie wielkie


    nop     ; no operation - do nothing


extern label            ; label is elsewhere and will be linked (you link it in makefile)
global label [, label]* ; label i global - seen in other files

label == ptr
aby pobrać wartość reg nie musi być wyłuskiwany, zmienna/labelka musi

* register  | reg   | register
* memory    | mem   | data in memory
* immediate | immed | const - part of instruction
* implied   |       | default operands like 1 in inc

    mov     dest,  src
    mov     reg,   reg      ; dest = src
    mov     reg,   [ptr]    ; dest = *ptr
    mov     [ptr], reg      ; *ptr = src
    mov     [ptr], [ptr]    ; *ptr = *ptr
    mov     reg,   ptr      ; dest = raw_ptr

    add     dest, arg   ; dest += arg
    sub     dest, arg   ; dest -= arg

    inc     dest        ; dest++
    dec     dest        ; dest--

    mul     source                      ; for u32
    mul     reg/mem8                ;     AX  = AL*source
    mul     reg/mem16               ;  DX:AX  = AX*source
    mul     reg/mem32               ; EDX:EAX = EAX*source
    imul    dest, source, source1       ; for i32
    imul    reg_, immed_            ; dest *= source
    imul    reg_, reg_/mem_, immed_ ; dest = source*source1

    div     source          ; for u32
    idiv    source          ; for i32
    div     src_08    ;  AL =     AX  div src_08     AH =     AX  mod src_08
    div     src_16    ;  AX =  DX:AX  div src_16     DX =  DX:AX  mod src_16
    div     src_32    ; EAX = EDX:EAX div src_32    EDX = EDX:EAX mod src_32
    div     src_64    ; RAX = RDX:RAX div src_64    RDX = RDX:RAX mod src_64

;;; adresowanie i pobieranie wartości z pamięci

    mov eax, 0x01020304             ; raw_ptr
    mov eax, label                  ; raw_ptr
    mov eax, [ptr]                  ; *ptr
    mov eax, array[ecx]             ; array[index]
    mov eax, [ebx + esi * 4 + 2]    ; adres = baza + indeks * skala + przesuniecie
    mov eax, [rip + offset]         ; retywny - względem aktualnej instrukcji - RIP

;;; operacje na flagach

    STC     ; Set Carry
    CLC     ; Clear Carry
    CMC     ; Complement Carry
    STD     ; Set Direction
    CLD     ; Clear Direction
    STI     ; Set Interrupt
    CLI     ; Clear Interrupt

;;; Konwersje (rozszerza bitem znaku)
 
    CBW    ;  AL into     AX      ; Byte->Word
    CWD    ;  AX into  DX:AX      ; Word->Double
    CDQ    ; EAX into EDX:EAX     ; Double->Quad
    CWDE   ;  AX into     EAX     ; Word->Double E
    CQO    ; RAX into RDX:RAX     ; Quad->Octa

;;; operacje na portach

    IN  Dest, Port
    OUT Port, Source

;;; sotos | stos jest kwantowany w dane po XX bitów
;;; x64 -> po 64b -> jak rozmiar RAX
;;; x32 -> po 32b -> jak rozmiar EAX
; wygląd [WAŻNE] RSP <= RBP | dół stosu ma większy adres niż top


0x___0 _ ^ RSP <- góra/szczyt stosu
0x__40 | | RSP+08B == RBP-24B
0x__80 | | RSP+16B == RBP-16B
0x__C0 | | RSP+24B == RBP-08B
0x_100 v _ RBP <- dół/podstawa/baza stosu 

    push rdx    ; wstaw na stos
    pushf       ; odkłada flagi
    ; pusha       ; odkłada wszystkie ogolne rejestry ALE (tylko architektura 32bit)

; jest równoważne       <==>
                        <==>    sub rsp, 8
    push rdx            <==>    mov [rsp], rdx


    pop rdx     ; zdejmij ze stosu
    popf        ; zdejmuje flagi
    ; popa        ; zdejmuje wszystkie ogolne rejestry ALE (tylko architektura 32bit)

; jest równoważne       <==>
                        <==>    mov rbx, [rsp]
    pop rbx             <==>    add rsp, 8


;;; operacje arytmetyczne
 
    ADD Dest,Source     ; Add
    ADC Dest,Source     ; Add with Carry
    SUB Dest,Source     ; Subtract
    SBB Dest,Source     ; Subtract with borrow
    DIV Op              ; Divide (unsigned
    IDIV Op             ; Signed Integer Divide
    MUL Op              ; Multiply (unsigned
    IMUL Op             ; Signed Integer Multiply
    INC Op              ; Increment
    DEC Op              ; Decrement
     
    CMP Op1,Op2         ; Compare
     
    SAL Op,Quantity     ; Shift arithmetic left     <<
    SAR Op,Quantity     ; Shift arithmetic right    >>
    RCL Op,Quantity     ; Rotate left through Carry     <=c=<
    RCR Op,Quantity     ; Rotate right through Carry    >=c=>
    ROL Op,Quantity     ; Rotate left   <==<
    ROR Op,Quantity     ; Rotate right  >==>

;;; operacje logiczne
 
    NEG Op              ; Negate (two-complement)
    NOT Op              ; Invert each bit
    AND Dest,Source     ; Logical and
    OR  Dest,Source     ; Logical or
    XOR Dest,Source     ; Logical exclusive or
    SHL Op,Quantity     ; Shift logical left    <<<<
    SHR Op,Quantity     ; Shift logical right   >>>>
     
    NOP                 ; No operation
    LEA Dest,Source     ; Load effective adress
    INT Nr              ; Interrupt


;;; MAKRA !!!!

%define nazwa 3 ; 3 = wartość

%macro nazwa 3 ; 3 = ilość argumentów
    mov rax, %1 ; %n = n-ty argument | iterując od 1 | czy 0 to sama nazwa makra ?
    push %2
    pop  %3
%endmacro

;;; porównania

    cmp x, y        ; porównaj x i y
                    ; oblicza x-y i ustawia odpowiednie flagi
                    ; PS wynik odejmowania NIE jest dostępny
                ; RFLAGS  ; holds flags related to the last operation
                    ; CF carry(borrow) flag - flaga przeniesienia
                    ; OF overflow flag - flaga przepełnienia
                    ; SF sign flag - flaga znaku
                    ; ZF zero flag - flaga zera
                    ; IF interrupt flag - flaga przerwań
                    ; PF parity flag - flaga parzystości
                    ; DF direction flag - flaga kierunku
        ; x == y    [ ZF=1 ]
        ; x < y     [ ZF=0 CF=1 ] unsigned
        ; x > y     [ ZF=0 CF=0 ] unsigned
        ; x < y     [ ZF=0 OF!=SF ] signed
        ; x > y     [ ZF=0 OF==SF ] signed
    test x, y       ; robi  if ((x & y) == 0) { ZF = true; }
    test rax, rax   ; w szczególności to testuje czy RAX == 0

;;; skoki

    JMP etykieta    ; jump/goto do podanego adresu/labelki
    
    etykieta:       ; oznaczenie miejsca w kodzie, nie istnieje po kompilacji
                    ; jej wystąpienia są podmienione na jej adres


                            ;Skok jeżeli w ostatniej operacji 
    JZ      ; ZF = 1    ; Jump Zero         ; był wykin 0
    JNZ     ; ZF = 0    ; Jump Not Zero
     
    JO      ; OF = 1    ; Jump Overflow     ; było przepełnienie   
    JNO     ; OF = 0    ; Jump Not Overflow
     
    JS      ; SF = 1    ; Jump Sign         ; wynik był ujemny 
    JNS     ; SF = 0    ; Jump Not Sign
     
    JC      ; SF = 1    ; Jump Carry(borrow); przepełnienie lub niedomiar dla liczb bez znaku
    JNC     ; SF = 0    ; Jump Not Carry(borrow)
     
    JP      ; PF = 1    ; Jump Parity       ; najmłodszy bajt ma parzystą liczbę jedynek 
    JNP     ; PF = 0    ; Jump Not Parity

;;; więcej skoków
    ; liczby ze znakiem     ; liczby bez znaku      ; skok jeżeli
    JE,  JZ                 JE,  JZ                 x = y             
    JNE, JNZ                JNE, JNZ                x != y         
    JL,  JNGE               JB,  JNAE               x < y           
    JLE, JNG                JBE, JNA                x <= y
    JG,  JNLE               JA,  JNBE               x > y
    JGE, JNL                JAE, JNB                x >= y

; SIGNED (ze znakiem) sufixy
    Jump [Not] Equal/Zero
    Jump [Not] Lesser  [Equal]
    Jump [Not] Greater [Equal]

; UNSIGNED (bez znaku) sufixy
    Jump [Not] Equal/Zero
    Jump [Not] Above [Equal]
    Jump [Not] Below [Equal]

;;; pętle? - nie - odmiana skoku na końcu pętli

    LOOP   label    ;   ecx--;   if (ecx!=0)          JMP label;
    LOOPZ  label    ;   ecx--;   if (ecx!=0 && ZF=1)  JMP label;
    LOOPNZ label    ;   ecx--;   if (ecx!=0 && ZF=0)  JMP label;

;;; funkcje
; funckje to tylko kawałki kodu (bez granic) a ich wywołania to skoki do labelek
    ; Name    Comment Syntax
    CALL Proc   ; Call subroutine - jump z dodatkowym działaniem
                ; robi jmp Proc oraz push miejsca do którego skoczyć spowrotem
    JMP  Dest   ; Jump
    RET  [size] ; Return from subroutine AND <optional> pop SIZE Bytes from the stack

; ostatnia wartość na stosie po wejściu
; do funkcji to adres powrotu z funkcji





;;; interfejsowanie z C i konwencje wołania funkcji

Wywołania systemowe Linux AMD64 - syscall

    Podprogram wykonujemy przez syscall.
    Numer funkcji systemowej w RAX
    Argumenty umieszczamy kolejno w rejestrach

    RDI, RSI, RDX, R10, R8, R9

    Argumentami mogą być liczby całkowite lub adresy pamięci.
    Wynik zwracany jest w rejestrze RAX.
    Wartości ujemne z zakresu [-4095, -1] oznaczają błąd.
    Wywołanie może niszczyć zawartość rejestrów RCX, R11.

; Konwencja cdecl

;     Argumenty są przekazywane przez stos w kolejności od prawej do lewej.
;     Argumenty ze stosu musi posprzątać fukcja wywołująca.
;     Wartości całkowite i adresy są zwracane w rejestrze EAX lub parze EDX:EAX, wartości zmiennoprzecinkowe zwracamy w rejestrze ST0.
;     Rejestry EAX, ECX i EDX mogą zostać dowolnie zmienione przez funkcję wywołującą. Pozostałe rejestry po powrocie z fukcji muszą pozostać niezmienione.
;     Rejestry zmiennoprzecinkowe ST0-ST7 przed wywołaniem funkcji i po powrocie z niej powinny być puste. Wyjątkiem jest ST0 jeżeli w nim zwracana jest wartość.
;     GCC wymaga aby stos był wyrównany do granicy 16-bajtowej przed wywołaniem funkcji.


; Konwencja cdecl - funkcja wywołująca

; Funkcja wywołująca:

;     zachowuje na stosie wartości rejestrów eax, ecx, edx (np. jeżeli przechowują liczniki pętli)
;     odkłada na stos argumenty aktualne dla podprogramu w kolejności od prawej do lewej (pierwszy argument jest odkładany jako ostatni)
;     wykonuje instrukcję call przekazując sterowanie do podprogramu
;     wynik znajduje się w al/ax/eax/edx:eax
;     po odzystaniu sterownania usuwa argumenty ze stosu (zwiększając rejestr esp)
;     przywraca wartości rejestrów eax, ecx, edx jeżeli były zachowywane


; Konwencja cdecl - funkcja wywoływana

; Podprogram może swobodnie modyfikować rejestry EAX, ECX, EDX pozostałe po wyjściu z podprogramu powinny być niezmienione.

;     Odkładamy na stosie wartość EBP, a wartość ESP zapisuje w EBP. Nie jest to konieczne jeżeli funkcja nie korzysta ze stosu.
;     Do argumentów odnosimy się relatywnie do EBP. Pierwszy znajduje się pod [EBP+8].
;     Zmiejszamy ESP rezerwując pamięć na stosie dla zmiennych lokalnych. Odnosimy się do nich ponownie relatywnie do EBP.
;     Odkładamy na stos wartości rejestrów, które są w podprogramie modyfikowane (poza EAX, ECX, EDX).
;     Wykonujemy kod podprogramu
;     Jeżeli chcemy zwrócić wartość to umieszczamy ją w rejestrze EAX (wartości zmienno-przecinkowe umieszczamy w ST0).
;     Odtwarzamy wartość rejestrów.
;     Odtwarzamy wartość ESP z EBP i ściągamy ze stosu poprzednią wartość EBP
;     Wracamy z funkcji przez instrukcję RET

Przekazywanie parametrów w trybach 64 bitowych (UNIX)

    pierwsze sześć argumentów, które są liczbami całkowitymi lub wskaźnikami (w kolejności od lewej do prawej) są umieszczane kolejno w rejestrach

    RDI, RSI, RDX, RCX, R8, R9

    Agumenty zmiennoprzecinkowe (poza long double) są umieszczane w rejestrach SSE:

    XMM0, XMM1, ..., XMM7

    Rejestr RAX powinien zawierać liczbę liczb zmiennoprzecinkowych umieszczonych w SSE
    Pozostałe argumenty są umieszczane na stosie w kolejności <!!!> od prawej do lewej <!!!>.
    Funkcja musi zachowywać wartość rejestrów:

    RBX, RBP, RSP, R12, R13, R14, R15

    Pozostałe rejestry (w tym zmiennoprzecinkowe) mogą być dowolnie modyfikowane,
    Wynik jest umieszczany w
        RAX, RDX - całkowitoliczbowy, wskaźnik
        XMM0,XMM1 - zmiennoprzecinkowy
        ST0, ST1 - long double
        pamięci pod adresem wskazanym przez RDI jeżeli zwraca się typ złożony.

; ważny dodatek
    Uwaga: Jeżeli przesyłamy przez wartość prostą strukturę to jest ona też umieszczana w rejestrach. 
    typedef struct {
      int a;
      int b;
    } Dane;
    W rejestrze RDI zostanie przesłana cała struktura dane.
    RDI=[[Dane.a][Dane.b]] 


    Jeżeli zwracamy przez wartość prostą strukturę to jeżeli zmieści się ona w rejestrach RAX,RDX,XMM0,XMM1 to tam należy ją umieścić. 
    Uwaga: musi to już być program C++ bo czyste C nie pozwala zwracać struktur z funkcji.

    Jeżeli zwracamy przez wartość dużą strukturę i nie zmieści się ona w rejestrach RAX,RDX,XMM0,XMM1 to do funkcji w RDI zostanie przesłany adres gdzie należy umieścić wynik. 
    to tak jakby funkcja dostawała dodatkowy parametr bo ma zwrucić większą rzecz
    wtedy staje się on PIERWSZYM parametrem a wszystkie inne są przesówane o jeden dalej
    w RAX zwracamy adres zwracanej struktury


;;; Interfejsowanie z C

; W pliku C deklarujemy funkcję jako zewnętrzną
extern int suma(int, int);

; W pliku assemblerowym musimy odpowiedni symbol
; zdefiniowac jako globalny, aby był widoczny
; w innych jednostach kompilacji 
global suma ; UWAGA ponieważ GCC to nazwa jest identyczna
suma:       ; kazdy inny kompilator wymaga prefix '_'




;;; stos

    push rdx    ; wstaw na stos
    pushf       ; odkłada flagi
    ; pusha       ; odkłada wszystkie ogolne rejestry ALE (tylko architektura 32bit)

; jest równoważne       <==>
                        <==>    sub rsp, 8
    push rdx            <==>    mov [rsp], rdx


    enter rozmiar, 0    ; ustawia ramkę stosu
; jest równoważne       <==>
    enter rozmiar, 0    <==>    push ebp               
                                mov  ebp, esp     
                                sub  esp, rozmiar

    leave               ; przywraca ramkę stosu
; jest równoważne       <==>
    leave               <==>    mov esp, ebp     
                                pop ebp

; ;;;
; calling a func and retriving params
; ;;;

; kiedy robisz
    call someFuncName
    ; zakładając, że zpushowałeś wcześniej jakieś argumenty
    ; stos będzie wyglądał jakoś tak ...
    0x0000
    0x0010
    ...
    0x0f10
    0x0f20  rsp     var_3 (value)       rsp-0
    0x0f30          var_2 (value)       rsp-var_2.size
    0x0f40          var_1 (value)       rsp-var_2.size-var_3.size
    0x0f50  rsp     arg_3 (pointer to)  rbp+4*64
    0x0f60          arg_2 (pointer to)  rbp+3*64
    0x0f70          arg_1 (pointer to)  rbp+2*64
    0x0f80          return pointer      rbp+1*64
    0x0f90  rbp     prev rbp            rbp+0*64
    0x0fa0  ...
