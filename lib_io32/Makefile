
# comlpiler assembler
AC = nasm
ACFLAGS = -f elf32 -F dwarf -g
# comlpiler c++
CC = gcc
CCFLAGS = -m32 -g
CCompile = -c

lib_io32 = 
lib_io32 += asm_io.o
lib_io32 += driver.o

lib_io32: ${lib_io32}

# $@ is the left side of the :
# $^ is the right side of the :
# $< is first arg on the right side of the :

# $@ : $^ ... ...
# $@ : $< <=first<=

asm_io.o: asm_io.asm
	${AC} ${ACFLAGS} $^ -o $@

driver.o: driver.c asm_io.inc
	${CC} ${CCFLAGS} ${CCompile} $< -o $@

.PHONY: clean # The .PHONY rule keeps make from doing something with a file named clean

clean:
	rm -f *.o
