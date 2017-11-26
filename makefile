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
io32 = lib_io32
io64 = lib_io64
Z1 = cw01
Z2 = cw02
Z3 = cw03
Z4 = cw04
Z5 = cw05
Z6 = cw06
Z7 = cw07
Z8 = cw08
Z9 = cw09

ALL = ${io32} ${io64} ${Z1} ${Z2} ${Z3} ${Z4} ${Z5}
all: ${ALL}
.PHONY: ${ALL}

# this is how you call other make inside a make
# remember, make executes the FIRST make rule it encounters and nothing more

${io32}:
	cd ${io32} && $(MAKE) ${MAKEFLAGS} clean

${io64}:
	cd ${io64} && $(MAKE) ${MAKEFLAGS} clean

${Z1}:
	cd ${Z1} && $(MAKE) ${MAKEFLAGS}

${Z2}:
	cd ${Z2} && $(MAKE) ${MAKEFLAGS}

${Z3}:
	cd ${Z3} && $(MAKE) ${MAKEFLAGS}

${Z4}:
	cd ${Z4} && $(MAKE) ${MAKEFLAGS}

${Z5}:
	cd ${Z5} && $(MAKE) ${MAKEFLAGS}

${Z6}:
	cd ${Z6} && $(MAKE) ${MAKEFLAGS}

${Z7}:
	cd ${Z7} && $(MAKE) ${MAKEFLAGS}

${Z8}:
	cd ${Z8} && $(MAKE) ${MAKEFLAGS}

${Z9}:
	cd ${Z9} && $(MAKE) ${MAKEFLAGS}

# # #
# clean targets
# # #
cio32 = clean_lib_io32
cio64 = clean_lib_io64
CZ1 = clean_cw01
CZ2 = clean_cw02
CZ3 = clean_cw03
CZ4 = clean_cw04
CZ5 = clean_cw05
CZ6 = clean_cw06
CZ7 = clean_cw07
CZ8 = clean_cw08
CZ9 = clean_cw09

.PHONY: clean
CLEAN_ALL = ${cio32} ${cio64} ${CZ1} ${CZ2} ${CZ3} ${CZ4} ${CZ5}
clean: ${CLEAN_ALL}

${cio32}:
	cd ${io32} && $(MAKE) ${MAKEFLAGS} clean

${cio64}:
	cd ${io64} && $(MAKE) ${MAKEFLAGS} clean

${CZ1}:
	cd ${Z1} && $(MAKE) ${MAKEFLAGS} clean

${CZ2}:
	cd ${Z2} && $(MAKE) ${MAKEFLAGS} clean

${CZ3}:
	cd ${Z3} && $(MAKE) ${MAKEFLAGS} clean

${CZ4}:
	cd ${Z4} && $(MAKE) ${MAKEFLAGS} clean

${CZ5}:
	cd ${Z5} && $(MAKE) ${MAKEFLAGS} clean

${CZ6}:
	cd ${Z6} && $(MAKE) ${MAKEFLAGS} clean

${CZ7}:
	cd ${Z7} && $(MAKE) ${MAKEFLAGS} clean

${CZ8}:
	cd ${Z8} && $(MAKE) ${MAKEFLAGS} clean

${CZ9}:
	cd ${Z9} && $(MAKE) ${MAKEFLAGS} clean
