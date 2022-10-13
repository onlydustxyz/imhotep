%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from src.onlydust.imhotep.stack import Stack, StackStruct
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.alloc import alloc

@external
func test_should_push_and_pop{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    let (stack) = Stack.init();
    let slot = Uint256(0, 0);
    with stack {
        Stack.push(slot);
        let (pop_slot) = Stack.pop();
    }
    assert pop_slot = slot;
    return ();
}

@external
func test_should_pop_and_push{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    let (stack) = Stack.init();
    let slot_0 = Uint256(0, 0);
    let slot_1 = Uint256(1, 0);
    with stack {
        Stack.push(slot_0);
        let (pop_0) = Stack.pop();
        assert pop_0 = slot_0;
        Stack.push(slot_1);
        let (peek_1) = Stack.peek();
        assert peek_1 = slot_1;
    }
    return ();
}
