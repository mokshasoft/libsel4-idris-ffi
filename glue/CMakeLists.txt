#
# Copyright 2019, Mokshasoft AB (mokshasoft.com)
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#

cmake_minimum_required(VERSION 3.7.2)

set(LIB glue)
project(${LIB} C)

file(GLOB static
    *.c
)

add_library(${LIB} EXCLUDE_FROM_ALL ${static})
target_include_directories(${LIB} PUBLIC .)
target_link_libraries(
    ${LIB}
    Configuration
    sel4
    muslc
)
