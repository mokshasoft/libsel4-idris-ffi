#
# Copyright 2018, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

libs-y += libidris-libsel4-ffi

# Precompile the Idris files in the libsel4 FFI according to autoconf.h

LIB_NAME := libidris-libsel4-ffi
LIB_DIR := $(SEL4_LIBS_PATH)/$(LIB_NAME)
SEL4_FFI_BUILD_DIR := $(BUILD_BASE)/$(LIB_NAME)
IDRFILES := $(patsubst $(LIB_DIR)/src/%,%,$(wildcard $(LIB_DIR)/src/seL4/*.idr))
IDRFILES_PP := $(addprefix $(SEL4_FFI_BUILD_DIR)/,$(IDRFILES))
AUTOCONF_FLAGS := $(SEL4_FFI_BUILD_DIR)/autoconf.flags
BUILD_DIRS := \
    $(SEL4_FFI_BUILD_DIR) \
    $(SEL4_FFI_BUILD_DIR)/seL4

# Generate a file containing command line flags that m4 understands
# from the autoconf.h file.
$(AUTOCONF_FLAGS): $(AUTOCONF_H_FILE) | $(BUILD_DIRS)
	@echo "[GEN] $@"
	$(Q)awk '$$1 ~ /#define/ {print "-D" $$2}' $(AUTOCONF_H_FILE) | \
		tr '\n' ' ' > $(AUTOCONF_FLAGS)

# Create build dirs
$(BUILD_DIRS):
	@echo "[MKDIR] $@"
	$(Q)mkdir -p $@

vpath %.idr $(LIB_DIR)/src

# Generate Idris files from the m4 and autoconf files
$(SEL4_FFI_BUILD_DIR)/%.idr: %.idr $(AUTOCONF_FLAGS) | $(BUILD_DIRS)
	@echo "[M4] $@"
	$(Q)m4 $(shell cat $(AUTOCONF_FLAGS)) $< > $@

# Compile the package
$(SEL4_FFI_BUILD_DIR)/00libsel4ffi-idx.ibc: $(IDRFILES_PP)
	@echo "[IDRIS] compiling $@"
	$(Q)( cd $(SEL4_FFI_BUILD_DIR) ; \
	  idris --build $(LIB_DIR)/libsel4ffi.ipkg)

# Compile everything including glue code
libidris-libsel4-ffi: $(libc) common libsel4 $(SEL4_FFI_BUILD_DIR)/00libsel4ffi-idx.ibc
