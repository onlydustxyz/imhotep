%lang starknet

// from starkware.cairo.common.dict import dict_read
// from starkware.cairo.common.dict_access import DictAccess
// from starkware.cairo.common.uint256 import Uint256
from src.onlydust.imhotep.stack import Stack
from src.onlydust.imhotep.stack import StackStruct

struct ProgramCounter {
    current: felt,
    next: felt,
}

func jump{range_check_ptr, pc: ProgramCounter, stack: StackStruct}() {
    // alloc_locals;
    // let (local jump_dest) = Stack.pop();
    // pc.current = jump_dest;
    pc.current = Stack.pop();

    with_attr error_message("jump: invalid jump destination") {
        pc.next = Stack.peek{stack=stack}();
    }
    return ();
}
