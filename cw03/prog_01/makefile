# # #
# assembler compiler
# # #
AC = nasm

ACFLAGS =
# # -l <list_file> : write listing to a list file <list_file>
# ACFLAGS += -l file.lst
# # -f <out_format> set output format to <out_format>
# # # elf64 == x86_64
# ACFLAGS += -f elf64
# # # elf32 == i386 == elf
ACFLAGS += -f elf32
# # -F <dbg_format> set debugging format to <dbg_format>
ACFLAGS += -F dwarf
# # -g : generate debug information in selected debugging format, see -F
ACFLAGS += -g
# # -o <file> : output to the <file>
# ACFLAGS += -o
# # -I<path> : add <path> to search paths for looking for the includes
ACFLAGS += -I../../lib_arh64/
ACFLAGS += -I../../lib_io32/
# # -D<macro>[=<value>] : pre-defines a macro
# ACFLAGS += -D<macro>[=<value>]
# # -w+foo : enables warning foo (equiv. -Wfoo)
# # -w-foo : disable warning foo (equiv. -Wno-foo)
ACFLAGS += -w-macro-params
# # -[eE] : preprocess only (writes output to stdout by default) - resolves macros
# ACFLAGS = -e
# ACFLAGS = -E


# # #
# c++ comlpiler
# # #
CC = gcc

CCFLAGS =
# -g : produce system-native debug information for gdb
CCFLAGS += -g
# -c : compile and assemble, but not link
CCFLAGS += -c
# -m32 : ???? allow compilation for 32bit
CCFLAGS += -m32


# # #
# linker
# # #
# LD = ld
LD = gcc

LDFLAGS =
# -g : produce system-native debug information for gdb
LDFLAGS += -g
# -m32 : ???? allow linking for 32bit
LDFLAGS += -m32
# -m XXX # ld linker emulation mode
# LDFLAGS += -m elf_i386
# LDFLAGS += -m elf_x86_64

# IMPORTANT !!! you need proper 32bit versions of libraries 
# for GCC to find and link/compile in 32bit mode
# the below solves the missing-sources-problem
# 
# sudo apt-get update
# sudo apt-get install libc6-dev-i386


# # #
# make flags
# # #
MAKEFLAGS = --no-print-directory


# file settings and commons
EXCERCISE = prog
MAIN = main
ASOURCE_ext = asm
CSOURCE_ext = c
OBJECT_ext = o
LIST_ext = lst

# lib_io32
lib_io32_dir = lib_io32
lib_io32_path = ../../${lib_io32_dir}
lib_io32 = 
lib_io32 += ${lib_io32_path}/asm_io.o
lib_io32 += ${lib_io32_path}/driver.o

# $@ is the left side of the :
# $^ is the right side of the :
# $< is first arg on the right side of the :

# $@ : $^ ... ...
# $@ : $< <=first<=

# remember, make executes the FIRST make rule it encounters and nothing more
# ${EXCERCISE}: ${EXCERCISE}.${OBJECT_ext} ${MAIN}.${OBJECT_ext}
${EXCERCISE}: ${EXCERCISE}.${OBJECT_ext} lib_io32
	${LD} ${LDFLAGS} $< ${lib_io32} -o $@

${EXCERCISE}.${OBJECT_ext}: ${EXCERCISE}.${ASOURCE_ext}
	${AC} ${ACFLAGS} -l ${EXCERCISE}.${LIST_ext} $^ -o $@

# ${MAIN}.${OBJECT_ext}: ${MAIN}.${CSOURCE_ext}
# 	${CC} ${CCFLAGS} $^ -o $@

${lib_io32_dir}:
	cd ${lib_io32_path} && $(MAKE) ${MAKEFLAGS}

clean_${lib_io32_dir}:
	cd ${lib_io32_path} && $(MAKE) ${MAKEFLAGS} clean


# The .PHONY rule keeps make from doing something with a file named clean
clean: clean_${EXCERCISE} clean_${lib_io32_dir}
clean_${EXCERCISE}:
	rm -f *.${OBJECT_ext}
	rm -f ${EXCERCISE}
	rm -f ${EXCERCISE}.${LIST_ext}
	rm -f makefile~
	rm -f *.gz
