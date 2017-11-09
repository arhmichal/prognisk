
; funkcja quadratic
; znajduje pierwiastki równania kwadratowego:
; a*x^2 + b*x + c = 0
; prototyp C:
; int quadratic( double a, double b, double c,
;                double * root1, double *root2 )
; Parametry:
; a, b, c - współczynniki równania
; root1 - wskaźnik do zmiennej typu double, przechowującej rozwiązanie
; root2 - j.w.
; Wartość zwracana:
; 1 jeśli istnieją pierwiastki rzeczywiste, w przeciwnym wypadku 0

 %define a qword [ebp+8]
 %define b qword [ebp+16]
 %define c qword [ebp+24]
 %define root1 dword [ebp+32]
 %define root2 dword [ebp+36]
 %define disc qword [ebp-8]
 %define one_over_2a qword [ebp-16]

 segment .data
 MinusFour dw -4

 segment .text
 global quadratic
 quadratic:

 push ebp
 mov ebp, esp
 sub esp, 16              ; alokacja pamięci na dane lokalne procedury (disc i one_over_2a)
 push ebx                 ; KONWENCJA C - musimy zachować oryginalne dane z rejestru EBX

 fild word [MinusFour]    ; stack -4
 fld a                    ; stack: a, -4
 fld c                    ; stack: c, a, -4
 fmulp st1                ; stack: a*c, -4
 fmulp st1                ; stack: -4*a*c
 fld b
 fld b                    ; stack: b, b, -4*a*c
 fmulp st1                ; stack: b*b, -4*a*c
 faddp st1                ; stack: b*b - 4*a*c
 ftst                     ; porównaj ST0 z 0
 fstsw ax                 ; przenosimy flagi C koprocesora do rejestru AX
 sahf                     ; przenosimy dane z AX do rejestrów flagowych procesora
                          ; powyższe dwie instrukcje są konieczne do stworzenia instrukcji warunkowej!!!

 jb no_real_solutions     ; if disc < 0, nie ma rozwiązań rzeczywistych
 fsqrt                    ; stack: sqrt(b*b - 4*a*c)
 fstp disc                ; store and pop stack
 fld1                     ; stack: 1.0
 fld a                    ; stack: a, 1.0
 fscale                   ; stack: a * 2^(1.0) = 2*a, 1
 fdivp st1                ; stack: 1/(2*a)
 fst one_over_2a          ; stack: 1/(2*a)
 fld b                    ; stack: b, 1/(2*a)
 fld disc                 ; stack: disc, b, 1/(2*a)
 fsubrp st1               ; stack: disc - b, 1/(2*a)
 fmulp st1                ; stack: (-b + disc)/(2*a)

 mov ebx, root1           ; ładuję adres root1 do rejestru
 fstp qword [ebx]         ; ściągam ze stosu do *root1
 fld b                    ; stack: b
 fld disc                 ; stack: disc, b
 fchs                     ; stack: -disc, b
 fsubrp st1               ; stack: -disc - b
 fmul one_over_2a         ; stack: (-b - disc)/(2*a)

 mov ebx, root2
 fstp qword [ebx]
 mov eax, 1               ; return 1
 jmp short quit

 no_real_solutions:
 mov eax, 0               ; return 0

 quit:
 pop ebx
 mov esp, ebp
 pop ebp
 ret
 