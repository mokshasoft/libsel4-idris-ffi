{-
Copyright 2018, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

{-
  ported from kernel/libsel4/arch_include/<arch>/sel4/arch/functions.h
-}

module seL4.Functions

%access public export
%default total

-- seL4_Word seL4_GetMR(int i)
-- void seL4_SetMR(int i, seL4_Word mr)
-- seL4_Word seL4_GetUserData(void)
-- void seL4_SetUserData(seL4_Word data)
-- seL4_CapData_t seL4_GetBadge(int i)
-- seL4_CPtr seL4_GetCap(int i)
-- void seL4_SetCap(int i, seL4_CPtr cptr)
-- void seL4_GetCapReceivePath(seL4_CPtr* receiveCNode, seL4_CPtr* receiveIndex, seL4_Word* receiveDepth)
-- void seL4_SetCapReceivePath(seL4_CPtr receiveCNode, seL4_CPtr receiveIndex, seL4_Word receiveDepth)
-- seL4_IPCBuffer* seL4_GetIPCBuffer(void)
