%lang starknet

from src.onlydust.imhotep.stack import StackStruct, Stack

func STOP{range_check_ptr, stack: StackStruct}() {
    return ();
}
