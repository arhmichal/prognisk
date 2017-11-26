%ifndef FUCK_BITS_MACRO__ASM
    %define FUCK_BITS_MACRO__ASM

%if __BITS__ == 32

    %idefine reax eax
    %idefine rebx ebx
    %idefine recx ecx
    %idefine redx edx
    %idefine redi edi
    %idefine resi esi
    %idefine resp esp
    %idefine rebp ebp

%elif __BITS__ == 64

    %idefine reax rax
    %idefine rebx rbx
    %idefine recx rcx
    %idefine redx rdx
    %idefine redi rdi
    %idefine resi rsi
    %idefine resp rsp
    %idefine rebp rbp

%else
    %error "unrecognized architecture - not x64 nor x32/86"
%endif

%endif
