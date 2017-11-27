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

SYSTEMOWE - syscall
Wywołania systemowe Linux AMD64 - syscall

    Podprogram wykonujemy przez syscall.
    Numer funkcji systemowej w RAX
    Argumenty umieszczamy kolejno w rejestrach

    RDI, RSI, RDX, R10, R8, R9

    Argumentami mogą być liczby całkowite lub adresy pamięci.
    Wynik zwracany jest w rejestrze RAX.
    Wartości ujemne z zakresu [-4095, -1] oznaczają błąd.
    Wywołanie może niszczyć zawartość rejestrów RCX, R11.

FUNKCJE 32BIT - call
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


FUNKCJE 64BIT - call
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
        !!! oznacza to, że jeśli zwracasz strukturę/klasę to jako pierwszy argument dostajesz wskaźnik do zwracanej struktury, reszta argumentów jest przepychana o jeden dalej !!!

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
            ; np




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
    ...     no local vars => rbp==rsp
    0x0f10
    0x0f20  rsp     var_3 (value)       rbp-3*8
    0x0f30          var_2 (value)       rbp-2*8
    0x0f40          var_1 (value)       rbp-1*8
    0x0f50  rbp     prev rbp (ptr)      rbp+0*8     enter effect
    0x0f60          return pointer      rbp+1*8     call effect
    0x0f70          arg_1 (pointer to)  rbp+2*8     push effect
    0x0f80          arg_2 (pointer to)  rbp+3*8     push effect
    0x0f90          arg_3 (pointer to)  rbp+4*8     push effect
    0x0fa0  ...
    ...
    0x1210  previous rbp        ; use ; ebp+n*4 ; for 32bit code
    ...

; adresowanie pośrednie np dla tablic
add dx, [rbx + 2*rcx - 2]   ; rbx ma pointer do tablicy
                            ; index można wyliczać też z wartości rejestru

; przydatne do podglądnięcia np. jaką nazwę ma funkcja, zwłaszcza gdy jest przeładowana

; convert cpp to asm
g++ -S plik.cpp -o plik.asm

; convert cpp to asm ; ze składnią bliską do NASM
g++ -masm=intel -S plik.cpp -o plik.asm

; hint przy interfejsowaniu
Wywołując niestatyczną metodę klasy jako pierwszy parametr przekazujemy adres obiektu

class A { public:
  char ma;                       
  void f() { cout << "\n f w A \n"; }
};
 
class B : public A { public:
  int mb;
  void f() { cout << "\n f w B \n"; }
};

rozmiar A == 1 ; char.zise == 1
rozmiar B == 8 !!! ; char.zise == 1, int.zise == 4
    ponieważ
    adres pola `ma` jest struct+0
    adres pola `mb` jest struct+4 !!! bo jest wyrównane do 4
        i tutaj ukryły się dodatkowe bajty, zupełónie nieurzywane, ale tam są
jeśli klasa ma funkcję virtualną, i huj, wtedy
    pole `ma` ma adres struct+8 ; dla 64bit
    bo pierwsza jest tablica funkcji virtualnych
    pole `mb` nadal jest wyrównane do 4, więc struck+12


; ; ;
; flołty i dable
; ; ;

"world ani`t all sunshine and rainbows ..."
"... it`s a mean and nasty place"
w myśl tej zasady, FPU to ODDZIELNA JEDNOSTA OBLICZEŃ, która ma
    - własny, inny zestaw poleceń
    - własny, nie synchronizowany zegar cykli procesora
    - własny stos
    - własne flagi warunkowe i wyjątki
    - ...
    - coś jeszcze o czym teraz jeszcze nie wiesz, bo to napewno nie koniec


Wszystkie instrukcje FPU [Float Processing Unit] poprzedzone są przedrostkiem F.

FPU ma CYKLICZNY STOS REJESTRÓW na liczby zmiennoprzecinkowe
rejestry:
    ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7 => STX oznacza X-ty rejestr
    ; gdzie ST0 zawsze wskazuje na szczyt stosu i przy push/pop przesówane są tylko wskaźniki

operacje
    F* - float
    *LD* - load
    *LG* - log
    *LN* - ln = log_e()
    *P - pop - zdejmuje ze stosu flołtów
    *I* - operation with INT

    FLD [mem32/64/80, STX] ; ST0 = arg
    ; umieszcza liczbę zmiennoprzecinkową pojedynczej, podwójnej lub rozszerzonej precyzji na szczycie stosu.
    ; src może być adresem pamięci lub rejestrem koprocesora.
    ; src nie może być rejesterem ogólnego przeznaczenia.
    FILD [mem16/32/64] ; ST0 = cast<float>(arg)
    
    ; Instrukcje ładowania stałych ; zapis ze slajdów
        FLDZ ; załaduj zero. ST0 = 0.0
        FLD1 ; załaduj 1. ST0 = 1.0
        FLDPI ; załaduj pi.
        FLDL2T ; załaduj log2(10)
        FLDL2E ; załaduj log2(e)
        FLDLG2 ; załaduj log(2)=log10(2)
        FLDLN2 ; załaduj ln(2)


Instrukcje które zdejmują wartość ze stosu mają przyrostek P, jeżeli zdejmują dwie wartości to PP

    FST [mem32/64/80 STX] ; mov target, ST0
    FSTP [mem32/64/80] ; FST + pop
    FIST [mem16/32] ; mov target, cast<int>(ST0) ; Sposób zaokrąglania zależy od flag koprocesora.
    FISTP [mem16/32/64] ; FiST + pop
    FXCH STX ; swap ST0 z STX.

arytmetyka
    ADD [FADD]
        FADD [mem32/64] / STX ; ST0 += arg
        FADD STX, ST0 ; STX += ST0
        FADDP ... ; FADD + pop
        FIADD [mem32/64] ; ST0 += cast<float>(arg)

    ; analogiczne operacje
    SUB [FSUB] analogicznie
        FSUB [mem32/64] / STX ; ST0 += arg
        FSUB STX, ST0 ; STX += ST0
        FSUBP ... ; FSUB + pop
        FISUB [mem32/64] ; ST0 += cast<float>(arg)
    SUBR [FSUBR] odwrucone odejmowanie
        FSUBR [mem32/64] / STX ; ST0 = arg - ST0
        FSUBR STX, ST0 ; STX = ST0 - STX
        FSUBRP ... ; FSUBR + pop
        FISUBR [mem32/64] ; ST0 = cast<float>(arg) - ST0
    MUL [FMUL] analogicznie
    DIV [FDIV] analogicznie
    DIVR [FDIVR] analogicznie, odwrucone dzielenie

    ; kolejne operacje na FPU
    FABS ; ST0 = |ST0| (wartość bezwzględna)
    FCHS ; ST0 = -ST0 (zmiana znaku)
    FSQRT ; ST0 = sqrt(ST0)
    FRNDINT ; ST0 = round(ST0)

    FSIN ; ST0 = sin(ST0)
    FCOS ; ST0 = cos(ST0)
    FSINCOS ; ST0 = cos(ST0), ST1 = sin(ST0)
    FPTAN ; partial_? ; ST0 = tg(ST0)
    FPATAN ; ST0 = atg(ST0)

    FYL2X ; ST1 = ST1 * log2(ST0) & pop
    FYL2XPI ; ST1 = ST1 * log2( ST0 + 1.0 ) & pop
    F2XM1 ; ST0 = 2^ST0 - 1
    ; & pop oznacza, że wynik będący w ST1 => ST0 przesówa się do ST0

FPU control word
    15 14 13 12 11 10 09 08 | 07 06 05 04 03 02 01 00 | bity flag
             _X __RC_ __PC_ |       PM UM OM ZM DM IM

    ; flagi konrtolne - zachowanie zaokrąglania, precyzja obliczeń, itd..
    12 : X : infinity controll
    11:10 : RC : rounding controll
        00 do najbliższej (równe? do parzystej)
        01 w dół (do -inf)
        10 w górę (do +inf)
        11 trunk (w kierunku 0)
    09:08 : PC : precision controll - precyzja przy obliczeniach
        00 24bit (float)
        01 ---
        10 53bit (double)
        11 64bit (long double) [default]

    ; maski wyjątków - czy rzucić wyjątkiem w danych sytuacjach
    ; default - ustawia odpowiednią flagę, ale nic nie rzuca
    05 : PM : precision mask
    04 : UM : underflow mask
    03 : OM : overflow mask
    02 : ZM : zero divide mask
    01 : DM : denormal operand mask
    00 : IM : invalid operand mask

FPU status word
    15 14 13 12 11 10 09 08 | 07 06 05 04 03 02 01 00 | bity flag
    _B C3 ___TOP__ C2 C1 C0 | ES SF PE UE OE ZE DE IE

    ; flagi konrtolne - zachowanie zaokrąglania, precyzja obliczeń, itd..
    15 : B : FPU busy
    14 : C3 : condition code 3
    13:12:11 : TOP : top of the stack pointer - index rejestru na szczycie stosu FPU
    10 : C2 : condition code 2
    09 : C1 : condition code 1
    09 : C0 : condition code 0
    ; C0, C1, C2, C3 - ustawiane przez instrukcje porównania, odpowiadają odpowiednim flagom procesora

    ; maski wyjątków - czy rzucić wyjątkiem w danych sytuacjach
    ; default - ustawia odpowiednią flagę, ale nic nie rzuca
    07 : ES : error summary status
    06 : SF : stack fault
    05 : PE : precision exception flag
    04 : UE : underflow exception flag
    03 : OE : overflow exception flag
    02 : ZE : zero divide exception flag
    01 : DE : denormal operand exception flag
    00 : IE : invalid operand exception flag

    FCLEX - Fpu CLear EXceptions - ręczne czyszczenie flag błędów w FPU - bo nie ma automatycznego
    ; flagi wyjątków 00-05 są ustawiane przez operazje FPU i zawierają NIR-TYLKO-STAN-OSTATNIEJ-OPERACJU więc potencjalnie błędo-genne, trzeba ręcznie je czyścic za pomocą FCLEX


Instrukcje kontrolne

    WAIT/FWAIT ; czekaj, aż FPU skończy pracę. Używane do synchronizacji z CPU.
    ; Wiele z poniższych instrukcji wywołuje tą instrukcję niejawnie.
    ; Wersje z literką *N* nie wywołują WAIT
    FINIT/FNINIT ; inicjalizacja FPU, przywraca FPU do domyślnego stanu: ustawia flagi, czyści stos.
    ; Dobrą praktyką jest wywoływanie go przed przystąpieniem do obliczeń (bo nie wiemy w jakim stanie inne funkcje zostawiły FPU)
    FLDCW, FSTCW/FNSTCW ; Load/Store control word - zapisuje 16 kontrolnych bitów do pamięci
    FSTSW/FNSTSW ; zapisz do pamięci (lub rejestru AX) słowo statusu, czyli stan FPU
    FCLEX/FNCLEX ; wyczyść wyjątki
    FLDENV, FSTENV/FNSTENV ; wczytaj/zapisz środowisko (rejestry stanu, kontrolny i kilka innych, bez rejestrów danych). Wymaga 14 albo 28 Bajtów pamięci, w zależności od trybu pracy procesora (rzeczywisty - DOS lub chroniony - Windows/Linux).
    FRSTOR, FSAVE/FNSAVE ; jak wyżej, tylko że z rejestrami danych. Wymaga 94 lub 108 bajtów w pamięci, zależnie od trybu procesora.
    FINCSTP, FDECSTP ; zwiększ/zmniejsz wskaźnik stosu
    FFREE ; zwolnij podany rejestr danych
    FNOP ; no operation. Nic nie robi, ale zabiera czas.


Komendy porównania

; FPU oprócz rejestrów danych zawiera także rejestr kontrolny (16 bitów) i rejestr stanu (16 bitów).
; W rejestrze stanu są 4 bity nazwane C0, C1, C2 i C3. To one wskazują wynik ostatniego porównania, a układ ich jest taki sam, jak flag procesora, co pozwala na ich szybkie przeniesienie do flag procesora.

; Aby odczytać wynik porównania, należy przenieść rejestr flag z koprocesora do procesora:
fcom       ;  porównujemy
fstsw ax   ;  STore StateWord to ax 
sahf       ;  mov AH, flag
; Następnie możemy używać rozkazów skoków tak jak dla liczb całkowitych bez znaku: JE, JB itp.

    FCOM STX/[mem] ; cmp ST0 STX/mem
    FCOMP STX/[mem] ; FCOM arg & pop
    FCOMPP ; cmp ST0 ST1 & pop & pop
    FICOM [mem] ; cmp ST0 <int>mem
    FICOMP [mem] ; FICOM arg & pop
    FCOMI ST0, STX ; cmp ST0 STX & ustaw flagi CPU, nie tylko FPU
    FCOMIP ST0, STX ; FCOMI arg1, arg2 & pop

; Komendy kończące się na *I lub *IP zapisują swój wynik bezpośrednio do flag procesora. Można tych flag od razu używać (JZ, JA, ...). Te komendy są dostępne od Pentium Pro.

FTST ; cmd ST0, 0


Typ liczby

FXAM ; sprawdza, co jest w ST0 - prawidłowa liczba, NaN, czy 0.
; Rodzaj liczby               C3  C2  C0
  Błędna liczba               0   0   0
  NaN                         0   0   1
  Zwykła liczba skończona     0   1   0
  Nieskończoność              0   1   1
  Zero                        1   0   0
  Pusty rejestr               1   0   1
  Liczba zdenormalizowana     1   1   0

Rejest C1 zawiera znak liczby w ST0
