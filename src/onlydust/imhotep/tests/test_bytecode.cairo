%lang starknet
from starkware.cairo.common.cairo_builtins import  HashBuiltin
from starkware.cairo.common.uint256 import Uint256 as Uint256

@contract_interface
namespace EvmBytecode {

    func get_bytecode() -> (code_len: felt, code: felt*){
    }
    
}

@external
func __setup__() {

    %{ context.contract_address = deploy_contract("./src/onlydust/imhotep/evm.cairo", { "_bytecode": [1, 2, 3] }).contract_address %}
    return ();
}

@external
func test_bytecode{pedersen_ptr: HashBuiltin*, syscall_ptr: felt*, range_check_ptr}() {
    alloc_locals;

    local addr;
    %{ ids.addr = context.contract_address %}

    let (code_len, code) =  EvmBytecode.get_bytecode(contract_address=addr);

    assert code_len = 3;

    assert [code] = 1;
    assert [code + 1] = 2;
    assert [code + 2] = 3;
    return ();
}
