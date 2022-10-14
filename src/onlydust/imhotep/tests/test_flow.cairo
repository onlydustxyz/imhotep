%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from src.onlydust.imhotep.flow import jump, ProgramCounter
from src.onlydust.imhotep.stack import Stack

@external
func test_should_jump_pc_to_popped_value{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    alloc_locals;
    local pc: ProgramCounter;
    assert pc = ProgramCounter(current=Uint256(1, 0), next=Uint256(0, 0));

    let (stack) = Stack.init();
    with pc, stack {
        let slot_0 = Uint256(0, 0);
        Stack.push(slot_0);
        let slot_1 = Uint256(1, 0);
        Stack.push(slot_1);

        jump();
        let (local peek) = Stack.peek();
    }
    assert peek = pc.next;
    return ();
}

@external
func test_should_revert_when_stack_is_empty{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    %{ expect_revert("TRANSACTION_FAILED", "jump: invalid jump destination") %}
    alloc_locals;
    local pc: ProgramCounter;
    assert pc = ProgramCounter(current=Uint256(1, 0), next=Uint256(0, 0));

    let (stack) = Stack.init();
    with pc, stack {
        let slot_0 = Uint256(1, 0);
        Stack.push(slot_0);

        jump();
        let (local peek) = Stack.peek();
    }
    assert peek = pc.next;
    return ();
}
