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

; zestaw  12
; zadanie 03
;
; Zaimplementuj funkcję 
; extern "C" double sum(Node ** tab, int size, ...);

; Funkcja powinna dla każdego obiektu w tablicy tab (o rozmiarze size) wywołać odpowiednią funkcję wirtualną w zależności od liczby podanych w "..." argumentów typu double (dla 0 - identity, dla 1 - inverse, dla 2 - compute, liczba argumentów zmiennoprzecinkowych znajduje się z rax). Do funkcji przekazujemy te argumenty zmiennoprzecinkowe. 
; Następnie należy zsumować zwrócone wartości i zwrócić tą sumę.  


; #include <iostream>

; using namespace std;

; // represents abstract operation #
; class Node{
;  public:
;   // return element such that x # identity() = x
;   virtual double identity() = 0;

;   // returns solution to x # a = identity()
;   virtual double inverse(double a) = 0;

;   // compute a # b
;   virtual double compute(double a, double b) = 0;

;   virtual ~Node(){}
; };

; class AddNode : public Node {
;  public:
;   virtual double inverse(double a) { return -a; }
;   virtual double compute(double a, double b) { return a + b; }
;   virtual double identity(){ return 0.0; }
; };

; class MulNode : public Node {
;  public:
;   virtual double inverse(double a) { return 1.0 / a; }
;   virtual double compute(double a, double b){ return a*b; }
;   virtual double identity(){ return 1.0; }
; };

; class SubNode : public Node {
;   public:
;   virtual double inverse(double a){ return a; }
;   virtual double compute(double a, double b) { return a - b; }
;   virtual double identity() { return 0.0; }
; };

; // returns sum of results returned by virtual functions calls
; // for each element of an array tab (of given size) we call
; // virtual function depending on how many floating point arguments are given in ...

; extern "C" double sum(Node ** tab, int size, ...);

; int main(){
;   Node * tab[] = {new AddNode(), new MulNode(), new SubNode() };
;   cout << sum(tab, 3) << endl;                   // 1.0
;   cout << sum(tab, 3, 4.0, 2.0) << endl;     // 16
;   cout << sum(tab, 3, 0.5) << endl;            // 2
;   cout << sum(tab, 2, 0.5) << endl;            // 1.5
;   return 0;
; }




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

