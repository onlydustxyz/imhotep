%lang starknet

// from starkware.cairo.common.dict import dict_read
// from starkware.cairo.common.dict_access import DictAccess
from src.onlydust.imhotep.stack import Stack
from src.onlydust.imhotep.stack import StackStruct

struct ProgramCounter {
    current: felt,
    next: felt,
}

func jump{range_check_ptr, pc: ProgramCounter}(state: StackStruct) {
    let (jump_dest) = Stack.pop{stack=state}();
    pc.current = jump_dest;

    with_attr error_message("jump: invalid jump destination") {
        pc.next = Stack.peek{stack=state}();
    }
    // with_attr error_message("jump: invalid instruction") {
    //     let (opcode) = dict_read{dict_ptr=opcodes}(key=jump_dest);
    // }
    return ();
}
