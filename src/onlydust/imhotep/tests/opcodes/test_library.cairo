%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from src.onlydust.imhotep.stack import Stack
from src.onlydust.imhotep.opcodes.library import Opcodes
from starkware.cairo.common.uint256 import Uint256
from src.onlydust.imhotep.opcodes.add import ADD
from src.onlydust.imhotep.opcodes.mul import MUL
from starkware.cairo.common.uint256 import assert_uint256_eq, uint256_add
from starkware.cairo.common.alloc import alloc

@external
func setup_should_execute_add_op{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
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
func test_should_execute_add_op{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    a_low, a_high, b_low, b_high
) {
    alloc_locals;
    let (stack) = Stack.init();
    let a = Uint256(a_low, a_high);
    let b = Uint256(b_low, b_high);
    let (args) = alloc();
    with stack {
        Stack.push(a);
        Stack.push(b);
        Opcodes.execute(Opcodes.ADD_CODE, 0, args);
        let (execute_output) = Stack.pop();
        Stack.push(a);
        Stack.push(b);
        ADD();
        let (op_output) = Stack.pop();
        assert_uint256_eq(op_output, execute_output);
    }

    return ();
}

@external
func setup_should_execute_mul_op{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
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
func test_should_execute_mul_op{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    a_low, a_high, b_low, b_high
) {
    alloc_locals;
    let (stack) = Stack.init();
    let a = Uint256(a_low, a_high);
    let b = Uint256(b_low, b_high);
    let (args) = alloc();
    with stack {
        Stack.push(a);
        Stack.push(b);
        Opcodes.execute(Opcodes.MUL_CODE, 0, args);
        let (execute_output) = Stack.pop();
        Stack.push(a);
        Stack.push(b);
        MUL();
        let (op_output) = Stack.pop();
        assert_uint256_eq(op_output, execute_output);
    }

    return ();
}
