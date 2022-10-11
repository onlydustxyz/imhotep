%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from src.onlydust.imhotep.stack import Stack
from starkware.cairo.common.uint256 import Uint256

from src.onlydust.imhotep.flow import jump

@external
func test_should_revert_for_invalid_opcode{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    %{ expect_revert("TRANSACTION_FAILED", "jump: invalid instruction") %}
    let (stack) = Stack.init();
    with stack {
        let slot_0 = Uint256(0, 0);
        Stack.push(slot_0);
    }
    jump(stack);
    return ();
}