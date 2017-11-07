BITS 32
section .text

global sort
sort:
	enter 0, 0
		
; po wykonaniu push ebp i mov ebp, esp:
; w [ebp]    znajduje się stary EBP
; w [ebp+4]  znajduje się adres powrotny z procedury
; w [ebp+8]  znajduje się pierwszy parametr,
; w [ebp+12] znajduje się drugi parametr
; itd.

%idefine a [ebp+8]
%idefine b [ebp+12]
%idefine c [ebp+16]

;wlasciwa funkcja
	xor esi, esi
	xor edi, edi

	mov eax, a
	mov ebx, b
	mov ecx, c

cmp_eax_ebx:	
	; ? a > b
	mov esi, [eax]
	mov edi, [ebx]
	cmp esi, edi
	jge cmp_ebx_ecx
	
	;swap a i b
	mov [ebx], esi
	mov [eax], edi
	
	;a >= b
	cmp_ebx_ecx:
		; ? b > c
		mov esi, [ebx]
		mov edi, [ecx]
		cmp esi, edi
		; a >= b >= c
		jge powrot
		
		; a >= b & b < c
		mov [ebx], edi
		mov [ecx], esi
		jmp cmp_eax_ebx		
; tu kończy się właściwy kod funkcji

powrot:
	leave ;usuwamy ramkę stosu LEAVE = MOV ESP, EBP / POP EBP
	ret
