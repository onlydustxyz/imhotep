%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256 as Bytes32
from starkware.cairo.common.alloc import alloc

@storage_var
func len_contr_bytecode() -> (len: felt) {
}

@storage_var
func contr_bytecode(index: felt) -> (res: felt) {
}

@storage_var
func storage(key: Bytes32) -> (value: Bytes32) {
}

@constructor
func constructor{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(contr_bytecode_len: felt, contr_bytecode: felt*) {
    len_contr_bytecode.write(contr_bytecode_len);
    process_array(contr_bytecode_len, contr_bytecode);

    return ();
}

func process_array{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(code_len: felt, code: felt*) {
    if (code_len == 0) { 
        return (); 
    }

    contr_bytecode.write(code_len - 1, code[code_len - 1]); 
    process_array(code_len - 1, code);
    return ();
}

func build_bytecode{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(code_len: felt, code: felt*) -> (code_len: felt, code: felt*) {
    if (code_len == 0) {
        return (code_len=0, code=code);
    }

    let (res) = contr_bytecode.read(code_len - 1);
    assert [code + code_len - 1] = res;
    let (code_len, code) = build_bytecode(code_len - 1, code);
    return (code_len=code_len, code=code);
}

@view
func get_bytecode{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}() -> (code_len: felt, code: felt*) {
    alloc_locals;
    let (len) = len_contr_bytecode.read();
    local len = len;

    let (bytecode: felt*) = alloc();
    build_bytecode(len, bytecode);


    return (code_len=len, code=bytecode);
}

func _sstore{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(key: Bytes32, value: Bytes32) {
    storage.write(key, value);

    return ();
}

func _sload{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}(key: Bytes32) -> (value: Bytes32) {
    let value = storage.read(key);

    return (value);
}
