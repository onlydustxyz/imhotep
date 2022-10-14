%lang starknet

from starkware.cairo.common.uint256 import Uint256
from src.onlydust.imhotep.stack import Stack
from src.onlydust.imhotep.stack import StackStruct

struct ProgramCounter {
    current: Uint256,
    next: Uint256,
}

func jump{range_check_ptr, pc: ProgramCounter, stack: StackStruct}() {
    alloc_locals;
    let (local jump_dest) = Stack.pop();
    assert pc.current = jump_dest;

    with_attr error_message("jump: invalid jump destination") {
        let (local peek) = Stack.peek();
        assert pc.next = peek;
    }
    return ();
}
