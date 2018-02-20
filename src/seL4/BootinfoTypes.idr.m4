{-
Copyright 2018, Mokshasoft AB (mokshasoft.com)

This software may be distributed and modified according to the terms of
the BSD 2-Clause license. Note that NO WARRANTY is provided.
See "LICENSE_BSD2.txt" for details.
-}

{-
  ported from file kernel/libsel4/include/sel4/bootinfo_types.h
-}

-- caps with fixed slot positions in the root CNode
public export
data Sel4Cap =
    SeL4_CapNull                -- null cap
  | SeL4_CapInitThreadTCB       -- initial thread's TCB cap
  | SeL4_CapInitThreadCNode     -- initial thread's root CNode cap
  | SeL4_CapInitThreadVSpace    -- initial thread's VSpace cap
  | SeL4_CapIRQControl          -- global IRQ controller cap
  | SeL4_CapASIDControl         -- global ASID controller cap
  | SeL4_CapInitThreadASIDPool  -- initial thread's ASID pool cap
  | SeL4_CapIOPort              -- global IO port cap (null cap if not supported)
  | SeL4_CapIOSpace             -- global IO space cap (null cap if no IOMMU support)
  | SeL4_CapBootInfoFrame       -- bootinfo frame cap
  | SeL4_CapInitThreadIPCBuffer -- initial thread's IPC buffer frame cap
  | SeL4_CapDomain              -- global domain controller cap
  | SeL4_NumInitialCaps

public export
SeL4_Word : Type
SeL4_Word = Int

public export
SeL4_Uint8 : Type
SeL4_Uint8 = Int

public export
SeL4_NodeId : Type
SeL4_NodeId = Int

public export
SeL4_Domain : Type
SeL4_Domain = Int

public export
SeL4_IPCBufferP : Type
SeL4_IPCBufferP = Int

public export
SeL4_SlotPos : Type
SeL4_SlotPos = SeL4_Word

public export
record SeL4_SlotRegion where
    constructor MKSeL4_SlotRegion
    start : SeL4_SlotPos
    end : SeL4_SlotPos

public export
record SeL4_UntypedDesc where
    constructor MKSeL4_UntypedDesc
    paddr : SeL4_Word     -- physical address of untyped cap
    padding1 : SeL4_Uint8
    padding2 : SeL4_Uint8
    sizeBits : SeL4_Uint8 -- size (2^n) bytes of each untyped
    isDevice : SeL4_Uint8 -- whether the untyped is a device

public export
record SeL4_BootInfo where
    constructor MKSeL4_BootInfo
    extraLen : SeL4_Word              -- length of any additional bootinfo information
    nodeID : SeL4_NodeId              -- ID [0..numNodes-1] of the seL4 node (0 if uniprocessor)
    numNodes : SeL4_Word              -- number of seL4 nodes (1 if uniprocessor)
    numIOPTLevels : SeL4_Word         -- number of IOMMU PT levels (0 if no IOMMU support)
    ipcBuffer : SeL4_IPCBufferP       -- pointer to initial thread's IPC buffer
    empty : SeL4_SlotRegion           -- empty slots (null caps)
    sharedFrames : SeL4_SlotRegion    -- shared-frame caps (shared between seL4 nodes)
    userImageFrames : SeL4_SlotRegion -- userland-image frame caps
    userImagePaging : SeL4_SlotRegion -- userland-image paging structure caps
    ioSpaceCaps : SeL4_SlotRegion     -- IOSpace caps for ARM SMMU
    extraBIPages : SeL4_SlotRegion    -- caps for any pages used to back the additional bootinfo information
    initThreadCNodeSizeBits : SeL4_Uint8 -- initial thread's root CNode size (2^n slots)
    initThreadDomain : SeL4_Domain    -- Initial thread's domain ID
    archInfo : SeL4_Word              -- tsc freq on x86, unused on arm
    untyped : SeL4_SlotRegion         -- untyped-object caps (untyped caps)
    -- seL4_UntypedDesc  untypedList[CONFIG_MAX_NUM_BOOTINFO_UNTYPED_CAPS]; -- information about each untyped

public export
record SeL4_BootInfoHeader where
    constructor MKSeL4_BootInfoHeader
    -- identifier of the following chunk. IDs are arch/platform specific
    id : SeL4_Word
    -- length of the chunk, including this header
    len : SeL4_Word


public export
Show SeL4_SlotRegion where
    show sl =
        "[" ++ show (start sl) ++ " --> " ++ show (end sl) ++ ")"

public export
Show SeL4_BootInfo where
    show bi =
        "Node " ++ show (nodeID bi) ++ " of " ++ show (numNodes bi) ++ "\n" ++
        "IOPT levels:     " ++ show (numIOPTLevels bi) ++ "\n" ++
        "IPC buffer:      " ++ show (ipcBuffer bi) ++ "\n" ++
        "Empty slots:     " ++ show (empty bi) ++ "\n" ++
        "sharedFrames:    " ++ show (sharedFrames bi) ++ "\n" ++
        "userImageFrames: " ++ show (userImageFrames bi) ++ "\n" ++
        "userImagePaging: " ++ show (userImagePaging bi) ++ "\n" ++
        "untyped:         " ++ show (untyped bi) ++ "\n" ++
        "Initial thread domain: " ++ show (initThreadDomain bi) ++ "\n" ++
        "Initial thread cnode size: " ++ show (initThreadCNodeSizeBits bi) ++ "\n" ++
        "List of untypeds\n" ++
        "------------------\n" ++
        "Paddr    | Size   | Device\n" ++
        "unimplemented...\n"

-- A function to create a dummy BootInfo before reading the proper one from the system.
public export
createDummyBootInfo : SeL4_BootInfo
createDummyBootInfo =
    MKSeL4_BootInfo
        0
        1
        2
        3
        4
        (MKSeL4_SlotRegion 5 6)
        (MKSeL4_SlotRegion 6 7)
        (MKSeL4_SlotRegion 8 9)
        (MKSeL4_SlotRegion 9 10)
        (MKSeL4_SlotRegion 10 11)
        (MKSeL4_SlotRegion 11 12)
        13
        14
        15
        (MKSeL4_SlotRegion 16 17)
