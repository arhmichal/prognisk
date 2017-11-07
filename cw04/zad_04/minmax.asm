BITS 32
section .text

global minmax        

minmax:
	enter 0, 0

; po wykonaniu push ebp i mov ebp, esp:
; w [ebp]    znajduje się stary EBP
; w [ebp+4]  znajduje się adres powrotny z procedury
; w [ebp+8]  znajduje się pierwszy parametr,
; w [ebp+12] znajduje się drugi parametr
; itd.

	%idefine MM [ebp + 8] ;adres MM
	%idefine size [ebp + 12]
	%idefine tab [ebp + 16]

;wlasciwa funkcja	
	mov ecx, size
	mov esi, tab ;min
	mov edi, tab ;max
	
	;gdy tylko 1 element
	cmp ecx, 1
	je print_score
	
	mov ebx, 1
	sub ecx, 1
	
	iter:
		mov edx, [ebp + 4 * ebx + 16]
		cmp_with_min: 
			cmp esi, edx
			jg change_min
		
		cmp_with_max:
			cmp edi, edx
			jl change_max
		add ebx, 1
	loop iter
	
	;wypisz znalezione
	print_score:
		mov eax, MM
		mov [eax], edi
		mov [eax + 4], esi
		jmp powrot
		
change_min:
	mov esi, edx
	jmp cmp_with_max

change_max:
	mov edi, edx
	add ebx, 1
	sub ecx, 1
	
	;czy nie koniec
	cmp ecx, 0
	je print_score
	
	jmp iter
		
powrot:
	leave ;usuwamy ramkę stosu LEAVE = MOV ESP, EBP / POP EBP
	ret
