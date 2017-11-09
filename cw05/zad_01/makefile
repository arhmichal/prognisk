# # #
# assembler compiler
# # #
AC = nasm

ACFLAGS =
# # -l <list_file> : write listing to a list file <list_file>
# ACFLAGS += -l file.lst
# # -f <out_format> set output format to <out_format>
ACFLAGS += -f elf64
# # -F <dbg_format> set debugging format to <dbg_format>
ACFLAGS += -F dwarf
# # -g : generate debug information in selected debugging format, see -F
ACFLAGS += -g
# # -o <file> : output to the <file>
# ACFLAGS += -o
# # -I<path> : add <path> to search paths for looking for the includes
ACFLAGS += -I../../lib_arh64/
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


# # #
# linker
# # #
LD = gcc

LDFLAGS =
# -g : produce system-native debug information for gdb
LDFLAGS += -g


# # #
# make flags
# # #
MAKEFLAGS = --no-print-directory


# file settings and commons
EXCERCISE = excercise
MAIN = main
ASOURCE_ext = asm
CSOURCE_ext = c
OBJECT_ext = o
LIST_ext = lst

# $@ is the left side of the :
# $^ is the right side of the :
# $< is first arg on the right side of the :

# $@ : $^ ... ...
# $@ : $< <=first<=

# remember, make executes the FIRST make rule it encounters and nothing more
${EXCERCISE}: ${EXCERCISE}.${OBJECT_ext} ${MAIN}.${OBJECT_ext}
	${LD} ${LDFLAGS} $^ -o $@

${EXCERCISE}.${OBJECT_ext}: ${EXCERCISE}.${ASOURCE_ext}
	${AC} ${ACFLAGS} -l ${EXCERCISE}.${LIST_ext} $^ -o $@

${MAIN}.${OBJECT_ext}: ${MAIN}.${CSOURCE_ext}
	${CC} ${CCFLAGS} $^ -o $@

# The .PHONY rule keeps make from doing something with a file named clean
clean: clean_${EXCERCISE}
clean_${EXCERCISE}:
	rm -f *.${OBJECT_ext}
	rm -f ${EXCERCISE}
	rm -f ${EXCERCISE}.${LIST_ext}
	rm -f makefile~
	rm -f *.gz

# # this is how you call other make inside a make
# ${lib_io64_dir}:
# 	cd ${lib_io64_path} && $(MAKE) ${MAKEFLAGS}

# # this is how you call other make inside a make
# clean_${lib_io64_dir}:
# 	cd ${lib_io64_path} && $(MAKE) ${MAKEFLAGS} clean
