%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from src.onlydust.imhotep.stack import Stack
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.alloc import alloc

@external
func test_should_revert_when_stack_is_empty{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    %{ expect_revert("TRANSACTION_FAILED", "pop: stack is empty") %}
    let (stack) = Stack.init();
    Stack.pop{stack=stack}();
    return ();
}

@external
func test_should_decrease_stack_size{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    let (stack) = Stack.init();
    with stack {
        Stack.push(Uint256(0, 0));
        Stack.pop();
    }
    assert stack.size = 0;
    return ();
}

@external
func test_should_return_last_slot_and_update_peek{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    alloc_locals;
    let (stack) = Stack.init();
    with stack {
        let slot_0 = Uint256(0, 0);
        Stack.push(slot_0);
        let slot_1 = Uint256(1, 0);
        Stack.push(slot_1);
        let (local slot) = Stack.pop();
        let (local peek) = Stack.peek();
    }
    assert slot = slot_1;
    assert peek = slot_0;
    return ();
}
