{-
Copyright 2018, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

{-
  ported from file kernel/libsel4/include/sel4/shared_types.h
-}

module seL4.SharedTypes

%access public export
%default total

SeL4_IPCBufferP : Type
SeL4_IPCBufferP = Int -- dummy definition at the moment
