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

; zestaw  07
; zadanie 04
;
; #include <cstdio>

; using namespace std;
; class Faktura{
; private:
;   int id;
;   float obrot;
;   float podatekNaliczony;
;   float stawkaPodatku; 
;   static int nextID; 
; public:
;   Faktura(double obrot,  double stawkaPodatku = 0.23, double podatekNaliczony = 0.0):
;   id(nextID++), obrot(obrot), 
;   podatekNaliczony(podatekNaliczony), stawkaPodatku(stawkaPodatku){}
; };

; int Faktura::nextID = 0;

; extern "C" float podatek(Faktura f);
; extern "C" void wypisz(const Faktura & f); 

; int main(){
;   Faktura buraki(1000,  0.23, 100);
;   printf("Podatek : %f\n", podatek( buraki));
;   wypisz(buraki);
;   return 0;
; }

; Dla powyższego kodu w C++ napisz moduł assemblerowy implementujący funkcje:

;     float podatek(Faktura f) - zwracającą należny podatek według wzoru:  
;     podatek= (obrót - podatekNaliczony) * stawkaPodatku
;     void wypisz(const Faktura & f) - wypisującą na ekran napis przy pomocy standardowej funkcji printf 
;     printf("Faktura %d : obrot %f podatek %f\n", f.id, f.obrot, podatek(f));

; Wskazówki:
; Obiekt klasy Faktura przekazywany do funkcji podatek przez wartość zostanie pocięty na kawałki 8 bajtowe: pierwszy trafi do RDI, drugi do XMM0. 
; Funkcja printf wymaga aby  

;     standard ABI64 był przestrzegany, w szczególności: stos był wyrównany,  w rejestrze RAX umieszczona była liczba argumentów w rejestrach XMM
;     liczby typu float były przekazane jako double (konwersja np. cvtss2sd). 

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

