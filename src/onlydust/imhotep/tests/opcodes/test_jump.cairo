%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from src.onlydust.imhotep.opcodes.jump import JUMP
from src.onlydust.imhotep.stack import Stack

@external
func setup_should_jump_pc_to_popped_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    ) {
    %{
        given(a_low = strategy.felts(rc_bound=True))
        given(a_high = strategy.felts(rc_bound=True))
        given(b_low = strategy.felts(rc_bound=True))
        given(b_high = strategy.felts(rc_bound=True))
    %}
    return ();
}

@external
func test_should_jump_pc_to_popped_value{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}(a_low, a_high, b_low, b_high) {
    alloc_locals;

    let pc = Uint256(a_low, a_high);
    let (stack) = Stack.init();

    let a = Uint256(a_low, a_high);
    let b = Uint256(b_low, b_high);
    
    with pc, stack {
        Stack.push(a);
        Stack.push(b);
        let (local peek) = Stack.peek();
        assert peek = b;
        JUMP();
        assert pc = b;
        let (local peek) = Stack.peek();
        assert peek = a;
    }
    return ();
}
