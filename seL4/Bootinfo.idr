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

peek8 : Ptr -> Int -> IO Int
peek8 ptr offset = do
    _val <- prim_peek8 ptr offset
    pure $ prim__zextB8_Int _val

ifdef(`CONFIG_ARCH_X86_64', `

wordSize : Int
wordSize = 8

b64ToInt : Bits64 -> Int
b64ToInt b = sum $
    List.zipWith (*)
                 (map (\p => pow 256 (the Nat p)) [7..0])
                 (map prim__zextB8_Int (b64ToBytes b))

peekWord : Ptr -> Int -> IO Int
peekWord ptr offset = do
    _val <- prim_peek64 ptr offset
    pure $ b64ToInt _val

')

ifdef(`CONFIG_ARCH_IA32', `

wordSize : Int
wordSize = 4

b32ToInt : Bits32 -> Int
b32ToInt b = sum $
    List.zipWith (*)
                 (map (\p => pow 256 (the Nat p)) [3..0])
                 (map prim__zextB8_Int (b32ToBytes b))

peekWord : Ptr -> Int -> IO Int
peekWord ptr offset = do
    _val <- prim_peek32 ptr offset
    pure $ b32ToInt _val

')

peekSlotRegion : Ptr -> Int -> IO SeL4_SlotRegion
peekSlotRegion ptr offset = do
    _start <- peekWord ptr (offset + 0)
    _end   <- peekWord ptr (offset + wordSize)
    pure $ MKSeL4_SlotRegion _start _end

ifdef(`CONFIG_ARCH_X86_64', `

seL4_GetBootinfo : IO SeL4_BootInfo
seL4_GetBootinfo = do
    ptr <- get_bootinfo_ptr
    _extraLen         <- peekWord ptr 0
    _nodeID           <- peekWord ptr 8
    _numNodes         <- peekWord ptr 16
    _numIOPTLevels    <- peekWord ptr 24
    _ipcBuffer        <- peekWord ptr 32
    _empty            <- peekSlotRegion ptr 40
    _sharedFrames     <- peekSlotRegion ptr 56
    _userImageFrames  <- peekSlotRegion ptr 72
    _userImagePaging  <- peekSlotRegion ptr 88
    _ioSpaceCaps      <- peekSlotRegion ptr 104
    _extraBIPages     <- peekSlotRegion ptr 120
    _initThreadCNodeSizeBits <- peek8 ptr 136
    _initThreadDomain <- peekWord ptr 137
    _archInfo         <- peekWord ptr 145
    _untyped          <- peekSlotRegion ptr 153
    pure $
        MKSeL4_BootInfo
            _extraLen
            _nodeID
            _numNodes
            _numIOPTLevels
            _ipcBuffer
            _empty
            _sharedFrames
            _userImageFrames
            _userImagePaging
            _ioSpaceCaps
            _extraBIPages
            _initThreadCNodeSizeBits
            _initThreadDomain
            _archInfo
            _untyped

')

ifdef(`CONFIG_ARCH_IA32', `

seL4_GetBootinfo : IO SeL4_BootInfo
seL4_GetBootinfo = do
    ptr <- get_bootinfo_ptr
    _extraLen         <- peekWord ptr 0
    _nodeID           <- peekWord ptr 4
    _numNodes         <- peekWord ptr 8
    _numIOPTLevels    <- peekWord ptr 12
    _ipcBuffer        <- peekWord ptr 16
    _empty            <- peekSlotRegion ptr 20
    _sharedFrames     <- peekSlotRegion ptr 28
    _userImageFrames  <- peekSlotRegion ptr 36
    _userImagePaging  <- peekSlotRegion ptr 44
    _ioSpaceCaps      <- peekSlotRegion ptr 52
    _extraBIPages     <- peekSlotRegion ptr 60
    _initThreadCNodeSizeBits <- peek8 ptr 68
    _initThreadDomain <- peekWord ptr 69
    _archInfo         <- peekWord ptr 73
    _untyped          <- peekSlotRegion ptr 77
    pure $
        MKSeL4_BootInfo
            _extraLen
            _nodeID
            _numNodes
            _numIOPTLevels
            _ipcBuffer
            _empty
            _sharedFrames
            _userImageFrames
            _userImagePaging
            _ioSpaceCaps
            _extraBIPages
            _initThreadCNodeSizeBits
            _initThreadDomain
            _archInfo
            _untyped

')
