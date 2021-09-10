######################################################################
#
# DESCRIPTION: Verilator Example: Small Makefile
#
# This calls the object directory makefile.  That allows the objects to
# be placed in the "current directory" which simplifies the Makefile.
#
# This file ONLY is placed under the Creative Commons Public Domain, for
# any use, without warranty, 2020 by Wilson Snyder.
# SPDX-License-Identifier: CC0-1.0
#
######################################################################
# Check for sanity to avoid later confusion

VVIS=../../infra/verilator-vis
HIDDEN=./.build_files
COMMON=$(VVIS)/common/hw
SCOMMON=$(VVIS)/common/sw
VISSTRUCT=$(SCOMMON)/vis_struct_gen/bin/vis_struct_gen
BRAM=$(COMMON)/Bram
LIBRAM=$(COMMON)/LIBram
SKIDBUFFER=$(COMMON)/SkidBuffer
FIFO=$(COMMON)/fifo/rtl/verilog/
VISUALISER=$(VVIS)/webserver

TOPMODULE=top_tb
#FILES = $(MMIO_TOP_HW)/top_tb.sv mmio.sv 

ifneq ($(words $(CURDIR)),1)
 $(error Unsupported: GNU Make cannot build in directories containing spaces, build elsewhere: '$(CURDIR)')
endif

######################################################################
# Set up variables

# If $VERILATOR_ROOT isn't in the environment, we assume it is part of a
# package install, and verilator is in your path. Otherwise find the
# binary relative to $VERILATOR_ROOT (such as when inside the git sources).
ifeq ($(VERILATOR_ROOT),)
VERILATOR = verilator
VERILATOR_COVERAGE = verilator_coverage
else
export VERILATOR_ROOT
VERILATOR = $(VERILATOR_ROOT)/bin/verilator
VERILATOR_COVERAGE = $(VERILATOR_ROOT)/bin/verilator_coverage
endif

VERILATOR_INCLUDES = -y $(BRAM)/ 
VERILATOR_INCLUDES += -y $(LIBRAM)/
VERILATOR_INCLUDES += -y $(SKIDBUFFER)/
VERILATOR_INCLUDES += -y $(FIFO)

VERILATOR_FLAGS =
# Generate C++ in executable form
VERILATOR_FLAGS += -cc --exe
# Generate makefile dependencies (not shown as complicates the Makefile)
#VERILATOR_FLAGS += -MMD
# Optimize
VERILATOR_FLAGS += -Os -x-assign 0 --top-module $(TOPMODULE) $(VERILATOR_INCLUDES)

# Link stuff
VERILATOR_FLAGS += -LDFLAGS -lstdc++
VERILATOR_FLAGS += -LDFLAGS -lboost_system
VERILATOR_FLAGS += -LDFLAGS -lssl        
VERILATOR_FLAGS += -LDFLAGS -lcrypto
VERILATOR_FLAGS += -LDFLAGS -lcpprest
VERILATOR_FLAGS += -LDFLAGS -lboost_program_options
VERILATOR_FLAGS += -LDFLAGS -lpthread

PLAT := $(shell uname -m)
ifeq ($(PLAT), arm64)
	VERILATOR_FLAGS  += -LDFLAGS -L$(shell brew --prefix boost)/lib
	VERILATOR_FLAGS  += -LDFLAGS -L$(shell brew --prefix rapidjson)/lib
	VERILATOR_FLAGS  += -LDFLAGS -L$(shell brew --prefix binutils)/lib
	VERILATOR_FLAGS  += -LDFLAGS -L$(shell brew --prefix openssl)/lib
	VERILATOR_FLAGS  += -LDFLAGS -L$(shell brew --prefix cpprestsdk)/lib
endif

# Make waveforms
VERILATOR_FLAGS += --trace
# Check SystemVerilog assertions
VERILATOR_FLAGS += --assert
# Generate coverage analysis
VERILATOR_FLAGS += --coverage
# Run Verilator in debug mode
#VERILATOR_FLAGS += --debug
# Add this trace to get a backtrace in gdb
#VERILATOR_FLAGS += --gdbbt


# Input files for Verilator
VERILATOR_INPUT = -f $(HIDDEN)/input.vc $(FILES) $(HIDDEN)/sim_main.cpp

######################################################################
default: run

vis_structs: vis_struct.json
	$(VISSTRUCT) -i vis_struct.json -v _vis.sv -c _vis.hpp

run: 
	@echo
	@echo "-- Verilator tracing example"

	@echo
	@echo "-- VERILATE ----------------"
	cp $(HIDDEN)/sim_main.cpp ./ 
	cp $(HIDDEN)/top_tb.sv ./ 
	cp $(HIDDEN)/input.vc ./ 

	$(VERILATOR) $(VERILATOR_FLAGS) $(VERILATOR_INPUT) 

	@echo
	@echo "-- BUILD -------------------"
# To compile, we can either
# 1. Pass --build to Verilator by editing VERILATOR_FLAGS above.
# 2. Or, run the make rules Verilator does:
#	$(MAKE) -j -C obj_dir -f Vtop.mk
# 3. Or, call a submakefile where we can override the rules ourselves:
	$(MAKE) -j -C obj_dir -f ../$(HIDDEN)/Makefile_obj

	@echo
	@echo "-- RUN ---------------------"
	@rm -rf logs
	@mkdir -p logs
	obj_dir/Vtop_tb +trace

	@echo
	@echo "-- COVERAGE ----------------"
	@rm -rf logs/annotated
	$(VERILATOR_COVERAGE) --annotate logs/annotated logs/coverage.dat

	@echo
	@echo "-- DONE --------------------"
	@echo "To see waveforms, open vlt_dump.vcd in a waveform viewer"
	@echo

	@cp logs/vlt_dump.vcd ./wavedump.vcd

# ~~~~~~~~~ The web frontend ~~~~~~~~~~~~~~~~~~~~~~~~

$(VISUALISER)/node_modules:
	(cd $(VISUALISER) && npm install ws)
	(cd $(VISUALISER) && npm install express)

visualiser: $(VISUALISER)/node_modules $(VISUALISER)/server.js index.html
	node $(VISUALISER)/server.js $(realpath $(VISUALISER)) index.html

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


######################################################################
# Other targets

build:
	$(VERILATOR) $(VERILATOR_FLAGS) $(VERILATOR_INPUT)
	$(MAKE) -j -C obj_dir -f ../$(HIDDEN)/Makefile_obj

show-config:
	$(VERILATOR) -V

maintainer-copy::
clean mostlyclean distclean maintainer-clean::
	-rm -rf obj_dir logs *.log *.dmp *.vpd coverage.dat core *.vcd _vis.sv _vis.hpp 
	-rm -rf sim_main.cpp input.vc top_tb.sv
	-rm -rf node_modules package-lock.json 
	
