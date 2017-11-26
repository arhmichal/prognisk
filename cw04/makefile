# # #
# make flags
# # #
MAKEFLAGS = --no-print-directory


# $@ is the left side of the :
# $^ is the right side of the :
# $< is first arg on the right side of the :

# $@ : $^ ... ...
# $@ : $< <=first<=


# # #
# targets
# # #
P1 = prog_01
P2 = prog_02
Z1 = zad_01
Z2 = zad_02
Z3 = zad_03
Z4 = zad_04

ALL = ${P1} ${P2} ${Z1} ${Z2} ${Z3} ${Z4}
all: ${ALL}
.PHONY: ${ALL}

# this is how you call other make inside a make
# remember, make executes the FIRST make rule it encounters and nothing more

${P1}:
	cd ${P1} && $(MAKE) ${MAKEFLAGS}

${P2}:
	cd ${P2} && $(MAKE) ${MAKEFLAGS}

${Z1}:
	cd ${Z1} && $(MAKE) ${MAKEFLAGS}

${Z2}:
	cd ${Z2} && $(MAKE) ${MAKEFLAGS}

${Z3}:
	cd ${Z3} && $(MAKE) ${MAKEFLAGS}

${Z4}:
	cd ${Z4} && $(MAKE) ${MAKEFLAGS}

# # #
# clean targets
# # #
CP1 = clean_${P1}
CP2 = clean_${P2}
CZ1 = clean_${Z1}
CZ2 = clean_${Z2}
CZ3 = clean_${Z3}
CZ4 = clean_${Z4}

.PHONY: clean
CLEAN_ALL = ${CP1} ${CP2} ${CZ1} ${CZ2} ${CZ3} ${CZ4}
clean: ${CLEAN_ALL}

${CP1}:
	cd ${P1} && $(MAKE) ${MAKEFLAGS} clean

${CP2}:
	cd ${P2} && $(MAKE) ${MAKEFLAGS} clean

${CZ1}:
	cd ${Z1} && $(MAKE) ${MAKEFLAGS} clean

${CZ2}:
	cd ${Z2} && $(MAKE) ${MAKEFLAGS} clean

${CZ3}:
	cd ${Z3} && $(MAKE) ${MAKEFLAGS} clean

${CZ4}:
	cd ${Z4} && $(MAKE) ${MAKEFLAGS} clean
