{-
Copyright 2018, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

module seL4.Bootinfo

import CFFI -- contrib package
import seL4.BootinfoTypes
import seL4.seL4Debug

%include C "ffi-bootinfo.h"

public export
get_bootinfo_ptr : IO Ptr
get_bootinfo_ptr = foreign FFI_C "get_bootinfo" (IO Ptr)

public export
seL4_GetBootinfo : IO SeL4_BootInfo
seL4_GetBootinfo = do
    ptr <- get_bootinfo_ptr
    val <- peek I64 (toCPtr ptr)
    debugPrint ("bootinfo.extraLen = " ++ show val ++ "\n")
    -- return dummy bootinfo until all values are read and returned correctly
    pure createDummyBootInfo
