%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256 as Bytes32
from starkware.cairo.common.alloc import alloc

@storage_var
func bytecode_len() -> (len: felt) {
}

@storage_var
func bytecode(index: felt) -> (res: felt) {
}

@storage_var
func storage(key: Bytes32) -> (value: Bytes32) {
}

@constructor
func constructor{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(_bytecode_len: felt, _bytecode: felt*) {
    bytecode_len.write(_bytecode_len);
    store_bytecode_loop(_bytecode_len, _bytecode);

    return ();
}

func store_bytecode_loop{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(_bytecode_len: felt, _bytecode: felt*) {
    if (_bytecode_len == 0) { 
        return (); 
    }

    bytecode.write(_bytecode_len - 1, _bytecode[_bytecode_len - 1]); 
    store_bytecode_loop(_bytecode_len - 1, _bytecode);
    return ();
}

func read_bytecode_loop{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(_bytecode_len: felt, _bytecode: felt*) -> (_bytecode_len: felt, _bytecode: felt*) {
    if (_bytecode_len == 0) {
        return (_bytecode_len=0, _bytecode=_bytecode);
    }

    let (res) = bytecode.read(_bytecode_len - 1);
    assert [_bytecode + _bytecode_len - 1] = res;
    let (_bytecode_len, _bytecode) = read_bytecode_loop(_bytecode_len - 1, _bytecode);
    return (_bytecode_len=_bytecode_len, _bytecode=_bytecode);
}

@view
func get_bytecode{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}() -> (_bytecode_len: felt, _bytecode: felt*) {
    alloc_locals;
    let (len) = bytecode_len.read();
    local len = len;

    let (bytecode: felt*) = alloc();
    read_bytecode_loop(len, bytecode);


    return (_bytecode_len=len, _bytecode=bytecode);
}

func _sstore{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(key: Bytes32, value: Bytes32) {
    storage.write(key, value);

    return ();
}

func _sload{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(key: Bytes32) -> (value: Bytes32) {
    let value = storage.read(key);

    return (value);
}
