%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256 as Bytes32

@storage_var
func storage(key: Bytes32) -> (value: Bytes32) {
}

func _sstore{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(key: Bytes32, value: Bytes32) {
    storage.write(key, value);

    return ();
}

func _sload{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(key: Bytes32) -> (value: Bytes32) {
    let value = storage.read(key);

    return (value);
}
