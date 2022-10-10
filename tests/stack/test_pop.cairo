%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from src.onlydust.imhotep.stack import Stack, StackStruct
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.alloc import alloc

@external
func test_should_revert_when_stack_is_empty{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    %{ expect_revert("TRANSACTION_FAILED", "pop: stack is empty") %}
    let slots: Uint256* = alloc();
    let stack = StackStruct(size=0, slots=slots);
    Stack.pop{stack=stack}();
    return ();
}

@external
func test_should_decrease_stack_size{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    alloc_locals;
    let (local slots: Uint256*) = alloc();
    assert slots[0] = Uint256(0, 0);
    let stack = StackStruct(size=1, slots=slots);
    Stack.pop{stack=stack}();
    assert stack.size = 0;
    return ();
}

@external
func test_should_return_last_slot_and_update_peek{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    alloc_locals;
    let (local slots: Uint256*) = alloc();
    assert slots[0] = Uint256(0, 0);
    assert slots[1] = Uint256(1, 0);
    let stack = StackStruct(size=2, slots=slots);
    with stack {
        let (slot) = Stack.pop();
        let (peek) = Stack.peek();
    }
    assert slot = slots[1];
    assert peek = slots[0];
    return ();
}
