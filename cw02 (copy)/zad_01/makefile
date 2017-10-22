# 
FILE = excercise
SOURCE = asm
OBJECT = o
LIST = lst

# comlpiler assembler
AC = nasm
AINCPATHS = 
AINCPATHS += -i ../path
ACFLAGS = -f elf64 -F dwarf -g -w-macro-params
# ACFLAGS += $AINCPATHS

# comlpiler c++
CC = gcc
CCFLAGS = -g
CCompile = -c

# lib_io64
lib_io64_dir = lib_io64
lib_io64_path = ../../${lib_io64_dir}
lib_io64 = 
lib_io64 += ${lib_io64_path}/asm64_io.o
lib_io64 += ${lib_io64_path}/driver64.o

# make flag
SILENT_DIR = --no-print-directory

# $@ is the left side of the :
# $^ is the right side of the :
# $< is first arg on the right side of the :

# $@ : $^ ... ...
# $@ : $< <=first<=

${FILE}: ${FILE}.${OBJECT} lib_io64
	${CC} ${CCFLAGS} ${lib_io64} $< -o $@

clean_${FILE}:
	rm -f *.${OBJECT}
	rm -f ${FILE}
	rm -f ${FILE}.${LIST}
	rm -f makefile~
	rm -f *.gz

${FILE}.${OBJECT}: ${FILE}.${SOURCE}
	${AC} ${ACFLAGS} -l ${FILE}.${LIST} $^ -o $@



${lib_io64_dir}:
	cd ${lib_io64_path} && $(MAKE) ${SILENT_DIR}

clean_${lib_io64_dir}:
	cd ${lib_io64_path} && $(MAKE) ${SILENT_DIR} clean


# The .PHONY rule keeps make from doing something with a file named clean
.PHONY: clean
clean: clean_${FILE} clean_${lib_io64_dir}
