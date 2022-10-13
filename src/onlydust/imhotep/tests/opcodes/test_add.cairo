%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from src.onlydust.imhotep.stack import Stack
from starkware.cairo.common.uint256 import Uint256
from src.onlydust.imhotep.opcodes.add import ADD
from starkware.cairo.common.uint256 import assert_uint256_eq, uint256_add

@external
func setup_should_update_stack_with_correct_value{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    %{
        given(a_low = strategy.felts(rc_bound=True))
        given(a_high = strategy.felts(rc_bound=True))
        given(b_low = strategy.felts(rc_bound=True))
        given(b_high = strategy.felts(rc_bound=True))
    %}
    return ();
}

@external
func test_should_update_stack_with_correct_value{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}(a_low, a_high, b_low, b_high) {
    alloc_locals;
    let (stack) = Stack.init();
    let a = Uint256(a_low, a_high);
    let b = Uint256(b_low, b_high);
    let (expected_result, _) = uint256_add(a, b);
    with stack {
        Stack.push(a);
        Stack.push(b);
        ADD();
        let (output) = Stack.peek();
        assert_uint256_eq(output, expected_result);
    }

    return ();
}
