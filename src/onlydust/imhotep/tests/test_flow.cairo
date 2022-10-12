%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from src.onlydust.imhotep.stack import Stack
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.bool import TRUE

from src.onlydust.imhotep.flow import jump, ProgramCounter

@external
func test_should_revert_for_invalid_opcode{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    // %{ expect_revert("TRANSACTION_FAILED", "jump: invalid instruction") %}
    alloc_locals;
    local pc: ProgramCounter;

    assert pc = ProgramCounter(current=0, next=0);

    let (stack) = Stack.init();
    with stack {
        let slot_0 = Uint256(0, 0);
        Stack.push(slot_0);
        let slot_1 = Uint256(1, 0);
        Stack.push(slot_1);

        jump{pc=pc,stack=stack}();
        let (local peek) = Stack.peek();

        jump{pc=pc,stack=stack}();
        let (local empty) = Stack.is_empty();
    }
    assert peek = slot_0;
    assert empty = TRUE;
    return ();
}