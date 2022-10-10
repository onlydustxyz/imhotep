%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from src.onlydust.imhotep.stack import Stack
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.alloc import alloc

@external
func test_should_revert_when_stack_is_empty{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    %{ expect_revert("TRANSACTION_FAILED", "peek: stack is empty") %}
    let (stack) = Stack.init();
    Stack.peek{stack=stack}();
    return ();
}

@external
func test_should_keep_the_stack_size{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    let (stack) = Stack.init();
    with stack {
        Stack.push(Uint256(0, 0));
        Stack.peek();
    }
    assert stack.size = 1;
    return ();
}

@external
func test_should_return_last_slot{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    ) {
    let (stack) = Stack.init();
    with stack {
        Stack.push(Uint256(0, 0));
        let slot = Uint256(1, 0);
        Stack.push(slot);
        let (peek) = Stack.peek();
    }
    assert peek = slot;
    return ();
}
