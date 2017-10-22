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
; zadanie 02
;

; Zaimplementuj (w asemblerze lub C++) funkcję zmien, która dla danego obiektu zmieni  działanie  pierwszej funkcji w tablicy funkcji wirtualnych (zwracającej inta), w ten sposób, że zwracany wynik będzie o jeden mniejszy od oryginalnego wyniku.  
; Dla uproszczenia przyjmujemy, że wszystkie klasy mają tylko jedną funkcję wirtualną.
; Funkcja ta może mieć różne nazwy i argumenty, nie koniecznie takie jak w poniższym przykładzie.
; #include <iostream>
; using namespace std;

; class A{
;   public:
;   virtual int oblicz(int n){
;     return n*n;
;   }
; };

; class B : public A {
;   public:
;   virtual int oblicz(int n){
;     return 3*n  - 4;
;   } 
; };

; class F {
;   public:
;   virtual int wylicz(int a, int b){
;   return a - b;
;   }
; };


; extern "C" void zmien(void * ptr);


; int main(){
;   A a, b; 
;   A *pa = new A, *pb = new B, *pc = new B; 
;   cout << pa->oblicz(1)<< " "<< pb->oblicz(2) << " " << pc->oblicz(3) << endl;
;   zmien(pa); zmien(pb);
;   cout << pa->oblicz(1)<< " "<< pb->oblicz(2) << " " << pc->oblicz(3)  << endl;
;   F *pf = new F;
;   cout << pf->wylicz(7, 2) << endl;
;   zmien(pf);
;   cout << pf->wylicz(7, 2) << endl;
;   return 0;
; }
; // Spodziewane wyjście:
; // 1 2 5
; // 0 1 5
; // 5
; // 4

; Wskazówka: Można wykorzystać np. poniższą strukturę (lub jej asemblerowy odpowiednik) aby zastąpić tablicę funkcji wirtualnych w danym obiekcie. Zadanie można zrobić w C++ poprzez odpowiednie konwersje lub w asemblerze.
; struct newVf{
;   size_t  top_offset;
;   void * typeinfo; 
;   void *f;         // wskaźnik na nową funkcję   
;   void *vf;        // wskaźnik na starą tablicę funkcji virtualnych
; }; 

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

