%lang starknet

from starkware.cairo.common.uint256 import Uint256
from src.onlydust.imhotep.stack import StackStruct, Stack

struct ProgramCounter {
    current: Uint256,
}

func JUMP{range_check_ptr, stack: StackStruct, pc: ProgramCounter}() {
    alloc_locals;
    let (local jump_dest) = Stack.pop();
    assert pc.current = jump_dest;

    // TODO: Add check that the opcode at the dest offset is a JUMPDEST
    return ();
}
