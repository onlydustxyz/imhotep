%lang starknet
from starkware.cairo.common.cairo_builtins import  HashBuiltin
from starkware.cairo.common.uint256 import Uint256 as Uint256

from src.onlydust.imhotep.evm import _sstore, _sload

@external
func test_storage{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}() {
    alloc_locals;
    local key: Uint256;
    local value: Uint256;

    assert key = Uint256(low=30, high=0);
    assert value = Uint256(low=10234, high=0);

    _sstore(key, value);
    let stored_value : Uint256 = _sload(key);

    assert stored_value = value;
    return ();
}
