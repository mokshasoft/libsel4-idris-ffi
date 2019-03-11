#
# Copyright 2019, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

cmake_minimum_required(VERSION 3.7.2)

add_subdirectory(glue)

file(GLOB ipkg_file
	seL4FFI.ipkg
)

# Files that need to be preprocessed by m4
file(GLOB sel4_m4_files
    seL4/*.idr
    seL4/Arch/*.idr
)

idris_add_configured_module(sel4ffi ${ipkg_file} ${sel4_m4_files})
idris_link_libraries(sel4ffi glue)
