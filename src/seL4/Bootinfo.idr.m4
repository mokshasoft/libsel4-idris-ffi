{-
Copyright 2018, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

module seL4.Bootinfo

import seL4.BootinfoTypes
import seL4.seL4Debug
import seL4.SharedTypes
import seL4.Types

%include C "ffi-bootinfo.h"
%access public export
%default total

get_bootinfo_ptr : IO Ptr
get_bootinfo_ptr = foreign FFI_C "get_bootinfo" (IO Ptr)

b32ToInt : Bits32 -> Int
b32ToInt b = sum $
    List.zipWith (*)
                 (map (\p => pow 256 (the Nat p)) [3..0])
                 (map prim__zextB8_Int (b32ToBytes b))

b64ToInt : Bits64 -> Int
b64ToInt b = sum $
    List.zipWith (*)
                 (map (\p => pow 256 (the Nat p)) [7..0])
                 (map prim__zextB8_Int (b64ToBytes b))

peek32 : Ptr -> Int -> IO Int
peek32 ptr offset = do
    _val <- prim_peek32 ptr offset
    pure $ b32ToInt _val

peekWord : Ptr -> Int -> IO Int
peekWord ptr offset = do
    _val <- prim_peek64 ptr offset
    pure $ b64ToInt _val

peekSlotRegion : Ptr -> Int -> IO SeL4_SlotRegion
peekSlotRegion ptr offset = do
    _start <- peekWord ptr (offset + 0)
    _end   <- peekWord ptr (offset + 8)
    pure $ MKSeL4_SlotRegion _start _end

seL4_GetBootinfo : IO SeL4_BootInfo
seL4_GetBootinfo = do
    ptr <- get_bootinfo_ptr
    -- get data
    _extraLen        <- peekWord ptr (8*0)
    _nodeID          <- peekWord ptr (8*1)
    _numNodes        <- peekWord ptr (8*2)
    _numIOPTLevels   <- peekWord ptr (8*3)
    _ipcBuffer       <- peekWord ptr (8*4)
    _empty           <- peekSlotRegion ptr (8*5)
    _sharedFrames    <- peekSlotRegion ptr (8*7)
    _userImageFrames <- peekSlotRegion ptr (8*9)
    _userImagePaging <- peekSlotRegion ptr (8*11)
    _ioSpaceCaps     <- peekSlotRegion ptr (8*13)
    _extraBIPages    <- peekSlotRegion ptr (8*15)
    -- return dummy bootinfo with some values replaced for correct ones
    pure $
        record { extraLen = _extraLen
               , nodeID = _nodeID
               , numNodes = _numNodes
               , numIOPTLevels = _numIOPTLevels
               , ipcBuffer = _ipcBuffer
               , empty = _empty
               , sharedFrames = _sharedFrames
               , userImageFrames = _userImageFrames
               , userImagePaging = _userImagePaging
               , ioSpaceCaps = _ioSpaceCaps
               , extraBIPages = _extraBIPages
               } createDummyBootInfo
