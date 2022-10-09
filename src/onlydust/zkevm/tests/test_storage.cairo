%lang starknet
from starkware.cairo.common.cairo_builtins import  HashBuiltin

from src.onlydust.zkevm.evm import _sstore, _sload, Word32

@external
func test_storage{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}() {
    alloc_locals;
    local key: Word32;
    local value: Word32;

    assert key = Word32(h=0, l=30);
    assert value = Word32(h=0, l=10234);

    _sstore(key, value);
    let stored_value : Word32 = _sload(key);

    assert stored_value = value;
    return ();
}