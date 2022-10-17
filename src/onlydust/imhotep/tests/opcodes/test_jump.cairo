%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from src.onlydust.imhotep.opcodes.jump import JUMP
from src.onlydust.imhotep.stack import Stack

@external
func setup_should_jump_pc_to_popped_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    ) {
    %{
        given(low = strategy.felts(rc_bound=True))
        given(high = strategy.felts(rc_bound=True))
    %}
    return ();
}

@external
func test_should_jump_pc_to_popped_value{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}(low, high) {
    alloc_locals;

    let pc = high;
    let (stack) = Stack.init();

    let a = Uint256(low=low, high=high);

    with pc, stack {
        Stack.push(a);
        let (local peek) = Stack.peek();
        assert peek = a;
        JUMP();
        assert pc = low;
    }
    return ();
}
