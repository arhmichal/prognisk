    extern  read_int
    extern  read_string
    extern  read_char

    extern  print_int
    extern  print_string
    extern  print_char

    extern  println_int
    extern  println_string
    extern  println_char

    extern  print_nl 

    extern  sub_dump_regs
    extern  sub_dump_mem
    extern  sub_dump_math
    extern  sub_dump_stack

%macro dump_regs 1
    push    qword %1
    call    sub_dump_regs
%endmacro
