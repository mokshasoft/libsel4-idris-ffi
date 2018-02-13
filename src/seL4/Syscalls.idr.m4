-- Included from Syscalls.idr.m4

{-
Copyright 2018, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

ifdef(`CONFIG_PRINTING', `

public export
seL4_DebugPutChar : Char -> IO ()
seL4_DebugPutChar c = foreign FFI_C "seL4_DebugPutChar" (Char -> IO ()) c

public export
seL4_DebugDumpScheduler : IO ()
seL4_DebugDumpScheduler = foreign FFI_C "seL4_DebugDumpScheduler" (IO ())

')

-- End of Syscalls.idr.m4
