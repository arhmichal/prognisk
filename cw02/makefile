# # #
# make flags
# # #
MAKEFLAGS = --no-print-directory


# # #
# targets
# # #
E1 = ex01
E2 = ex02
E3 = ex03
E4 = ex04
Z1 = zad_01
Z2 = zad_02
Z3 = zad_03
Z4 = zad_04


# $@ is the left side of the :
# $^ is the right side of the :
# $< is first arg on the right side of the :

# $@ : $^ ... ...
# $@ : $< <=first<=

# this is how you call other make inside a make
# remember, make executes the FIRST make rule it encounters and nothing more
all: ${E1} ${E2} ${E3} ${E4}
# # #
# # make target CAN'T be the same as a subdir
# # #

${E1}:
	cd ${Z1} && $(MAKE) ${MAKEFLAGS}

${E2}:
	cd ${Z2} && $(MAKE) ${MAKEFLAGS}

${E3}:
	cd ${Z3} && $(MAKE) ${MAKEFLAGS}

${E4}:
	cd ${Z4} && $(MAKE) ${MAKEFLAGS}

# The .PHONY rule keeps make from doing something with a file named clean
.PHONY: clean
clean: clean_${E1} clean_${E2} clean_${E3} clean_${E4}

clean_${E1}:
	cd ${Z1} && $(MAKE) ${MAKEFLAGS} clean

clean_${E2}:
	cd ${Z2} && $(MAKE) ${MAKEFLAGS} clean

clean_${E3}:
	cd ${Z3} && $(MAKE) ${MAKEFLAGS} clean

clean_${E4}:
	cd ${Z4} && $(MAKE) ${MAKEFLAGS} clean
