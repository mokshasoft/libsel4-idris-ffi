/*
 * Copyright 2018, Mokshasoft AB (mokshasoft.com)
 *
 * This software may be distributed and modified according to the terms of
 * the BSD 2-Clause license. Note that NO WARRANTY is provided.
 * See "LICENSE_BSD2.txt" for details.
 */

#include "ffi-bootinfo.h"
#include <stdlib.h> // getent
#include <stdio.h> // sscanf

seL4_BootInfo * get_bootinfo(void) {
    char *bootinfo_addr_str = getenv("bootinfo");
    void *bootinfo;
    sscanf(bootinfo_addr_str, "%p", &bootinfo);
    return (seL4_BootInfo*)bootinfo;
}
