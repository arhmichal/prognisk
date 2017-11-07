BITS 32
section .text 

global mul_vector ;KONWENCJA!!! - funkcja ma być widziana w innych modułach aplikacji
 
mul_vector:
	enter 0, 0	;tworzymy ramkę stosu na początku funkcji
                ;ENTER 0,0 = PUSH EBP / MOV EPB, ESP
	
; po wykonaniu push ebp i mov ebp, esp:
; w [ebp]    znajduje się stary EBP
; w [ebp+4]  znajduje się adres powrotny z procedury
; w [ebp+8]  znajduje się pierwszy parametr,
; w [ebp+12] znajduje się drugi parametr
; itd.

%idefine size [ebp+8]
%idefine vector [ebp+12]

; wlasciwa funkcja
	xor ecx, ecx
	mov ecx, size
	
	;wynik
	xor ebx, ebx
	mov ebx, 1
	
	mov edx, vector
	
	iter:
		xor eax, eax
		mov eax, [edx + 4 * ecx - 4]
		imul eax, ebx
		mov ebx, eax
	loop iter
	
; tu kończy się właściwy kod funkcji


leave ;usuwamy ramkę stosu LEAVE = MOV ESP, EBP / POP EBP
ret
