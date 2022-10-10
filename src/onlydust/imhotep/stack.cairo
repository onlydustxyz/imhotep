%lang starknet

from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.math_cmp import is_not_zero
from starkware.cairo.common.bool import FALSE
from starkware.cairo.common.math import assert_lt_felt

struct StackStruct {
    size: felt,
    slots: Uint256*,
}

namespace Stack {
    const MAX_STACK_SIZE = 1024;

    func pop{stack: StackStruct}() -> (slot: Uint256) {
        with_attr error_message("pop: stack is empty") {
            let (value) = is_empty();
            assert value = FALSE;
        }
        let slot: Uint256 = stack.slots[stack.size - 1];
        let stack = StackStruct(size=stack.size - 1, slots=stack.slots);
        return (slot=slot);
    }

    func push{range_check_ptr, stack: StackStruct}(slot: Uint256) {
        with_attr error_message("push: stack reached max stack size") {
            assert_lt_felt(stack.size, MAX_STACK_SIZE);
        }
        assert stack.slots[stack.size] = slot;
        let stack = StackStruct(size=stack.size + 1, slots=stack.slots);
        return ();
    }

    func peek{stack: StackStruct}() -> (slot: Uint256) {
        with_attr error_message("peek: stack is empty") {
            let (value) = is_empty();
            assert value = FALSE;
        }
        let slot = stack.slots[stack.size - 1];
        return (slot=slot);
    }

    func is_empty{stack: StackStruct}() -> (value: felt) {
        let value = is_not_zero(stack.size);
        return (value=1 - value);
    }
}
