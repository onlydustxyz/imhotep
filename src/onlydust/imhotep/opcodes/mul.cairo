%lang starknet

from src.onlydust.imhotep.stack import StackStruct, Stack
from starkware.cairo.common.uint256 import uint256_mul

func MUL{range_check_ptr, stack: StackStruct}() {
    alloc_locals;
    let (local a) = Stack.pop();
    let (local b) = Stack.pop();
    let (output, _) = uint256_mul(a, b);
    Stack.push(output);
    return ();
}
