%lang starknet

from src.onlydust.imhotep.stack import StackStruct, Stack
from starkware.cairo.common.uint256 import uint256_add

func ADD{range_check_ptr, stack: StackStruct}() {
    alloc_locals;
    let (local b) = Stack.pop();
    let (local a) = Stack.pop();
    let (output, _) = uint256_add(a, b);
    Stack.push(output);
    return ();
}
