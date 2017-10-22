
FILE=excercise
SOURCE=asm
OBJECT=o

AC=nasm
CFLAGS= -f elf64 -F dwarf
LFLAGS= 

OBJ_FILES= ${FILE}.${OBJECT}

%.${OBJECT}: %.${SOURCE}
	${AC} ${CFLAGS} $< -o $@

# $@ is the left side of the :
# $^ is the right side of the :
# $< is first arg on the right side of the :

# $@ : $^ ... ...
# $@ : $< <=first<=

${FILE}: ${OBJ_FILES}

	ld ${LFLAGS} $^ -o $@

# linkowanie: 
# ld -m elf_x86_64  $FILE.o -o $FILE
# czy potrzebna mi taka flaga  -m elf_x86_64  ???

.PHONY: clean # The .PHONY rule keeps make from doing something with a file named clean

clean:
	rm -f *.${OBJECT}
	rm -f ${FILE}
	rm -f makefile~
	rm -f *.gz
