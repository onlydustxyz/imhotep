%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from src.onlydust.imhotep.stack import Stack, StackStruct
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.bool import FALSE, TRUE

@external
func test_should_return_true_when_stack_is_empty{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    let slots: Uint256* = alloc();
    let stack = StackStruct(size=0, slots=slots);
    let (bool) = Stack.is_empty{stack=stack}();
    assert bool = TRUE;
    return ();
}

@external
func test_should_return_false_when_stack_is_not_empty{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    let slots: Uint256* = alloc();
    assert slots[0] = Uint256(0, 0);
    let stack = StackStruct(size=1, slots=slots);
    let (bool) = Stack.is_empty{stack=stack}();
    assert bool = FALSE;
    return ();
}
