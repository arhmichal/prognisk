

; NASM 32 bit: program zapisany w pliku hello.asm
; kompilacja: nasm -felf hello.asm -o hello.o
; linkowanie: ld hello.o -o hello
; linkowanie w systemach 64-bit:  ld -m elf_i386 hello.o -o hello
 

section .text      ; początek sekcji z kodem

global _start      ; linker ld domyślnie rozpoczyna wykonywanie 
                   ; programu od etykiety _start
_start:            ; musi ona być widoczna na zewnątrz (global)

  mov eax, 4       ; numer funkcji systemowej:  
                   ;  4= sys_write - zapisz do pliku
  mov ebx, 1       ; numer pliku, do którego piszemy.
                   ; 1 = standardowe wyjście = ekran
  mov ecx, tekst   ; ECX = adres (offset) tekstu
  mov edx, dlugosc ; EDX = długość tekstu
  int 80h          ; wywołujemy funkcję systemową

  mov eax, 1       ; numer funkcji systemowej
                   ; (1=sys_exit - wyjdź z programu)
  int 80h          ; wywołujemy funkcję systemową

section .data      ; początek sekcji danych.

  tekst db "Czesc", 0ah  ; nasz napis, który wyświetlimy + enter 
  dlugosc equ $ - tekst  ; makro obliczające długość napisu
                         ; (to nie jest zmienna)

