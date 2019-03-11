/*
 * Copyright 2018, Mokshasoft AB (mokshasoft.com)
 *
 * This software may be distributed and modified according to the terms of
 * the BSD 2-Clause license. Note that NO WARRANTY is provided.
 * See "LICENSE_BSD2.txt" for details.
 */

#include "ffi-syscalls.h"
#include <sel4/sel4.h>

void ffi_seL4_Send(seL4_Word dest, seL4_Word msgInfo) {
    seL4_MessageInfo_t info;
    info.words[0] = msgInfo;
    seL4_Send(dest, info);
}
