%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from src.onlydust.imhotep.stack import Stack, StackStruct
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.alloc import alloc

@external
func test_should_revert_when_stack_is_max_size{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    %{ expect_revert("TRANSACTION_FAILED", "push: stack reached max stack size") %}
    let slots: Uint256* = alloc();
    let max_stack_size = Stack.MAX_STACK_SIZE;
    let stack = StackStruct(size=0, slots=slots);
    _stack_fixture_loop{stack=stack, target_stack_size=max_stack_size}(0);
    let slot = Uint256(max_stack_size + 1, 0);
    Stack.push{stack=stack}(slot);
    return ();
}

func _stack_fixture_loop{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
    stack: StackStruct,
    target_stack_size: felt,
}(index: felt) {
    if (index == target_stack_size) {
        return ();
    }
    Stack.push(Uint256(index, 0));
    return _stack_fixture_loop(index + 1);
}

@external
func test_should_increase_stack_size{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    alloc_locals;
    let (local slots: Uint256*) = alloc();
    let stack = StackStruct(size=0, slots=slots);
    let slot = Uint256(1, 0);
    Stack.push{stack=stack}(slot);
    assert stack.size = 1;
    return ();
}

@external
func test_should_update_peek_with_given_slot{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    alloc_locals;
    let (local slots: Uint256*) = alloc();
    assert slots[0] = Uint256(0, 0);
    let stack = StackStruct(size=1, slots=slots);
    let slot = Uint256(1, 0);
    with stack {
        let (previous_peek) = Stack.peek();
        Stack.push(slot);
        let (new_peek) = Stack.peek();
    }
    assert previous_peek = slots[0];
    assert new_peek = slot;
    return ();
}
