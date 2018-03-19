{-
Copyright 2018, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

{-
  ported from kernel/libsel4/include/sel4/syscalls.h
-}

module seL4.Syscalls

import seL4.SharedTypes

%include C "ffi-syscalls.h"

%access public export
%default total

-- void seL4_Send(seL4_CPtr dest, seL4_MessageInfo_t msgInfo);
seL4_Send : Int -> SeL4_MessageInfo -> IO ()
seL4_Send dest msgInfo =
    foreign FFI_C "ffi_seL4_Send" (Int -> SeL4_MessageInfo -> IO ()) dest msgInfo

-- seL4_MessageInfo_t seL4_Recv(seL4_CPtr src, seL4_Word* sender);
-- seL4_MessageInfo_t seL4_Call(seL4_CPtr dest, seL4_MessageInfo_t msgInfo);
-- void seL4_Reply(seL4_MessageInfo_t msgInfo);
-- void seL4_NBSend(seL4_CPtr dest, seL4_MessageInfo_t msgInfo);
-- seL4_MessageInfo_t seL4_ReplyRecv(seL4_CPtr dest, seL4_MessageInfo_t msgInfo, seL4_Word *sender);
-- seL4_MessageInfo_t seL4_NBRecv(seL4_CPtr src, seL4_Word* sender);

-- void seL4_Yield(void);
seL4_Yield : IO ()
seL4_Yield = foreign FFI_C "seL4_Yield" (IO ())

-- void seL4_Signal(seL4_CPtr dest);
-- void seL4_Wait(seL4_CPtr src, seL4_Word *sender);
-- seL4_MessageInfo_t seL4_Poll(seL4_CPtr src, seL4_Word *sender);

ifdef(`CONFIG_PRINTING', `

-- void seL4_DebugPutChar(char c);
seL4_DebugPutChar : Char -> IO ()
seL4_DebugPutChar c = foreign FFI_C "seL4_DebugPutChar" (Char -> IO ()) c

-- void seL4_DebugDumpScheduler(void);
seL4_DebugDumpScheduler : IO ()
seL4_DebugDumpScheduler = foreign FFI_C "seL4_DebugDumpScheduler" (IO ())

')

ifdef(`CONFIG_DEBUG_BUILD', `

-- void seL4_DebugHalt(void);
seL4_DebugHalt : IO ()
seL4_DebugHalt = foreign FFI_C "seL4_DebugHalt" (IO ())

-- void seL4_DebugSnapshot(void);
seL4_DebugSnapshot : IO ()
seL4_DebugSnapshot = foreign FFI_C "seL4_DebugSnapshot" (IO ())

-- seL4_Uint32 seL4_DebugCapIdentify(seL4_CPtr cap);

-- void seL4_DebugNameThread(seL4_CPtr tcb, const char *name);
seL4_DebugNameThread : Int -> String -> IO ()
seL4_DebugNameThread cap name =
    foreign FFI_C "seL4_DebugNameThread" (Int -> String -> IO ()) cap name

')

ifdef(`CONFIG_DANGEROUS_CODE_INJECTION', `

-- void seL4_DebugRun(void (* userfn) (void *), void* userarg);

')

ifdef(`CONFIG_ENABLE_BENCHMARKS', `

-- seL4_Error seL4_BenchmarkResetLog(void);
-- seL4_Word seL4_BenchmarkFinalizeLog(void);
-- seL4_Error seL4_BenchmarkSetLogBuffer(seL4_Word frame_cptr);

-- void seL4_BenchmarkNullSyscall(void);
seL4_BenchmarkNullSyscall : IO ()
seL4_BenchmarkNullSyscall = foreign FFI_C "seL4_BenchmarkNullSyscall" (IO ())

-- void seL4_BenchmarkFlushCaches(void);
seL4_BenchmarkFlushCaches : IO ()
seL4_BenchmarkFlushCaches = foreign FFI_C "seL4_BenchmarkFlushCaches" (IO ())

ifdef(`CONFIG_BENCHMARK_TRACK_UTILISATION', `

-- void seL4_BenchmarkGetThreadUtilisation(seL4_Word tcb_cptr);
-- void seL4_BenchmarkResetThreadUtilisation(seL4_Word tcb_cptr);

')
')

ifdef(`CONFIG_ARCH_X86', `
ifdef(`CONFIG_VTX', `

-- seL4_Word seL4_VMEnter(seL4_Word *sender);

')
')
