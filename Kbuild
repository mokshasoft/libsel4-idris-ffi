#
# Copyright 2018, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

# Precompile the Idris files in the libsel4 FFI according to autoconf.h

LIB_NAME := idris-libsel4-ffi
LIB_DIR := $(SEL4_LIBS_PATH)/$(LIB_NAME)
SEL4_FFI_BUILD_DIR := $(BUILD_BASE)/$(LIB_NAME)
M4FILES := $(shell find -L $(LIB_DIR) -name '*.idr.m4')
AUTOCONF_FLAGS_M4 := $(SEL4_FFI_BUILD_DIR)/autoconf.flags.m4
SEL4_IDR := $(SEL4_FFI_BUILD_DIR)/seL4/seL4.idr

# Generate a file containing command line flags that m4 understands
# from the autoconf.h file.
$(AUTOCONF_FLAGS_M4): $(AUTOCONF_H_FILE)
	@echo "Generating autoconf.flags.m4"
	$(Q)mkdir -p $(SEL4_FFI_BUILD_DIR)
	$(Q)awk '$$1 ~ /#define/ {print "-D" $$2}' $(AUTOCONF_H_FILE) | \
		tr '\n' ' ' > $(AUTOCONF_FLAGS_M4)

# Generate seL4.idr
$(SEL4_IDR): $(AUTOCONF_FLAGS_M4) $(M4FILES)
	@echo "Precompiling idris-libsel4-ffi"
	$(Q)mkdir -p $(SEL4_FFI_BUILD_DIR)/seL4
	$(Q)m4 -I $(LIB_DIR)/src/seL4 \
		$(shell cat $(AUTOCONF_FLAGS_M4)) \
		$(LIB_DIR)/src/seL4/seL4.idr.m4 > \
		$(SEL4_IDR)

.PHONY: $(LIB_NAME)
$(LIB_NAME): $(SEL4_IDR)
