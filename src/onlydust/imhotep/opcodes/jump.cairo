%lang starknet

from starkware.cairo.common.uint256 import Uint256
from src.onlydust.imhotep.stack import StackStruct, Stack

func JUMP{range_check_ptr, stack: StackStruct, pc: felt}() {
    alloc_locals;
    let (local jump_dest) = Stack.pop();
    let pc = jump_dest.low;

    // TODO: Add check that the opcode at the dest offset is a JUMPDEST
    return ();
}
