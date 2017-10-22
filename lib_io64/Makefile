
# comlpiler assembler
AC = nasm
ACFLAGS = -f elf64 -F dwarf -g
# comlpiler c++
CC = gcc
CCFLAGS = -g
CCompile = -c

lib_io64 = 
lib_io64 += asm64_io.o
lib_io64 += driver64.o

lib_io64: ${lib_io64}

# $@ is the left side of the :
# $^ is the right side of the :
# $< is first arg on the right side of the :

# $@ : $^ ... ...
# $@ : $< <=first<=

asm64_io.o: asm64_io.asm
	${AC} ${ACFLAGS} $^ -o $@

driver64.o: driver64.c asm64_io.inc
	${CC} ${CCFLAGS} ${CCompile} $< -o $@

.PHONY: clean # The .PHONY rule keeps make from doing something with a file named clean

clean:
	rm -f *.o
