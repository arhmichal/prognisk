%define NL 10

section .data   ; Initialized data

    f_ln                    db      NL, 0
    f_int                   db      "%li", 0
    f_int_ln                db      "%li", NL, 0
    f_str                   db      "%s", 0
    f_str_ln                db      "%s", NL, 0

section .bss    ; UnInitialized data

section .data   ; arrays

section .text   ; the code parto of file

; zestaw  08
; zadanie 03 (2pkt)
;

; Poniższa klasa BigInt reprezentuje bardzo duże liczby całkowite bez znaku. Liczbę taka przechowujemy następująco:
; zapisujemy ją binarnie, a następnie tniemy na kawałki po 32 bity i każdy taki kawałek jest przechowywany jako liczba unsigned int w tablicy dane. 

; Dla klasy BigInt 

; // Funkcje z zadania 2

; // kopiuje n liczb typu int z zrodla do celu 
; void kopiuj(int * cel, int * zrodlo, unsigned int n)

; // zeruje tablice liczb typu int o rozmiarze n
; void zeruj(int * cel, unsigned int n)

; class BigInt{
;   unsigned int rozmiar; 
;   insigned int * dane;      
; public:
;   explicit BigInt(unsigned int rozmiar) 
;     : rozmiar(rozmiar),
;       dane( new int[rozmiar] ){
;     zeruj(dane, rozmiar);
;   }
;   BigInt(const BigInt & x) 
;     :  rozmiar(x.rozmiar),
;        dane(new int[x.rozmiar]){ 
;     kopiuj(dane, x.dane, x.rozmiar);
;   }  
;   BigInt & operator=(const BigInt & x) {
;     if(rozmiar != x.rozmiar){
;       int * tmp = new int[x.rozmiar];
;       delete[] dane; 
;       rozmiar = x.rozmiar;
;       dane = tmp;
;     }
;     kopiuj(dane, x.dane, x.rozmiar);
;     return *this;
;   }
;   ~BigInt(){        
;     delete[] dane;
;   }
  
; // do zaimplementowania w zadaniu 3
;   int dodaj(unsigned int n);
;   int pomnoz(unsigned int n);
;   int podzielZReszta(unsigned int n);
  
;   BigInt & operator=(const char * liczba);
;   friend std::ostream & operator << (std::ostream & str, const BigInt & x);

; // do zaimplementowania w zadaniu 4
;   friend BigInt operator+ (const BigInt & a, const BigInt & b);
;   friend BigInt operator- (const BigInt & a, const BigInt & b);
  
; };

; zaimplementuj w asemblerze metody 

;     int BigInt::dodaj(unsigned int n);
;     dodaje do obiektu BigInt (modyfikując go) liczbę całkowitą n,
;     funkcja zwraca 1 jeżeli nastąpiło przepełnienie liczby BigInt, 0 w przeciwnym wypadku,
;     (w praktyce dodajemy n do  dane[0] a potem tylko propagujemy przeniesienie)

;     int BigInt::pomnoz(unsigned int n);
;     mnoży obiekt BigInt  przez n (modyfikując obiekt),
;     funkcja zwraca 1 jeżeli nastąpiło przepełnienie liczby BigInt, 0 w przeciwnym wypadku,

;     unsigned int BigInt::podzielZReszta(unsigned int n);
;     dzieli obiekt BigInt przez n (modyfikując go) i zwraca resztę z dzielenia.

; Z ich pomocą (można już w języku C++) zdefiniuj operatory:

;     wypisania liczby BigInt do strumienia 
;     przypisania łańcucha tekstowego, zawierającego liczbę np.   a="1234214243543543543243543534";

extern  printf  ; the C function, to be called
extern  scanf   ; the C function, to be called

; macros - cause they are like functions, easier, convinient
;          AND CAN BE OVERLOADED !!!!

%macro sys_exit 0           ; no longer used because of using lib_io64
    mov     rax, 60         ; sys_exit()
    syscall                 ; call;
%endmacro

%macro print 1
    mov     rdi, %1
    mov     rax, 0
    call    printf
%endmacro

%macro print 2
    mov     rdi, %1
    mov     rsi, %2
    mov     rax, 0
    call    printf
%endmacro

%macro print 3
    mov     rdi, %1
    mov     rsi, %2
    mov     rdx, %3
    mov     rax, 0
    call    printf
%endmacro

%macro scan 2
    mov     rdi, %1
    mov     rsi, %2
    mov     rax, 0
    call    scanf
%endmacro

%macro return 0
    leave
    ret 0;
%endmacro

%macro return 1
    leave
    ret %1;
%endmacro

; global _start   ; makes it public
; _start:         ; the main() of assembler ; no longer used because of using lib_io64

global asm_main
asm_main:
    enter 0,0
    call zeroReg
void_main:

    return;





; support functions

zeroReg:
    mov     rax, 0
    mov     rbx, 0
    mov     rcx, 0
    mov     rdx, 0
    mov     rdi, 0
    mov     rsi, 0
    ret;

pushReg:
    enter   0,0
    push    rax
    push    rbx
    push    rcx
    push    rdx
    push    rdi
    push    rsi
    return;

popReg:
    enter   0,0
    pop     rsi
    pop     rdi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rax
    return;

