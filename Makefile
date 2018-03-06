#
# Copyright 2018, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

# Target
TARGETS := libidris-libsel4-ffi.a

# Source files required to build the target
FILES := \
    ffi-bootinfo.c
CFILES := $(addprefix src/glue/,$(FILES))

# Libraries needed by the library
LIBS = \
    c \
    sel4

# Header file directory this library provides
HDRFILES := $(wildcard ${SOURCE_DIR}/src/glue/*)

CFLAGS += -W -Wall

include $(SEL4_COMMON)/common.mk
