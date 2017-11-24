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
Z1 = zad_01
Z2 = zad_02
Z3 = zad_03
Z4 = zad_04

ALL = ${Z1} ${Z2} ${Z3} ${Z4}
all: ${ALL}
.PHONY: ${ALL}

# this is how you call other make inside a make
# remember, make executes the FIRST make rule it encounters and nothing more

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
CZ1 = clean_zad_01
CZ2 = clean_zad_02
CZ3 = clean_zad_03
CZ4 = clean_zad_04

.PHONY: clean
CLEAN_ALL = ${CZ1} ${CZ2} ${CZ3} ${CZ4}
clean: ${CLEAN_ALL}

${CZ1}:
	cd ${Z1} && $(MAKE) ${MAKEFLAGS} clean

${CZ2}:
	cd ${Z2} && $(MAKE) ${MAKEFLAGS} clean

${CZ3}:
	cd ${Z3} && $(MAKE) ${MAKEFLAGS} clean

${CZ4}:
	cd ${Z4} && $(MAKE) ${MAKEFLAGS} clean
