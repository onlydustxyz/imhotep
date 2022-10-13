%lang starknet

from src.onlydust.imhotep.stack import Stack, StackStruct
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.registers import get_label_location
from starkware.cairo.common.invoke import invoke
from starkware.cairo.common.memcpy import memcpy
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.lang.compiler.lib.registers import get_fp_and_pc

from src.onlydust.imhotep.opcodes.add import ADD
from src.onlydust.imhotep.opcodes.mul import MUL
from src.onlydust.imhotep.opcodes.stop import STOP

namespace Opcodes {
    const STOP_CODE = 0x00;
    const ADD_CODE = 0x01;
    const MUL_CODE = 0x02;
    const SUB_CODE = 0x03;
    const DIV_CODE = 0x04;
    const SDIV_CODE = 0x05;
    const MOD_CODE = 0x06;
    const SMOD_CODE = 0x07;
    const ADDMOD_CODE = 0x08;
    const MULMOD_CODE = 0x09;
    const EXP_CODE = 0x0a;
    const SIGNEXTEND_CODE = 0x0b;
    const LT_CODE = 0x10;
    const GT_CODE = 0x11;
    const SLT_CODE = 0x12;
    const SGT_CODE = 0x13;
    const EQ_CODE = 0x14;
    const ISZERO_CODE = 0x15;
    const AND_CODE = 0x16;
    const OR_CODE = 0x17;
    const XOR_CODE = 0x18;
    const NOT_CODE = 0x19;
    const BYTE_CODE = 0x1a;
    const SHL_CODE = 0x1b;
    const SHR_CODE = 0x1c;
    const SAR_CODE = 0x1d;
    const KECCAK256_CODE = 0x20;
    const ADDRESS_CODE = 0x30;
    const BALANCE_CODE = 0x31;
    const ORIGIN_CODE = 0x32;
    const CALLER_CODE = 0x33;
    const CALLVALUE_CODE = 0x34;
    const CALLDATALOAD_CODE = 0x35;
    const CALLDATASIZE_CODE = 0x36;
    const CALLDATACOPY_CODE = 0x37;
    const CODESIZE_CODE = 0x38;
    const CODECOPY_CODE = 0x39;
    const GASPRICE_CODE = 0x3a;
    const EXTCODESIZE_CODE = 0x3b;
    const EXTCODECOPY_CODE = 0x3c;
    const RETURNDATASIZE_CODE = 0x3d;
    const RETURNDATACOPY_CODE = 0x3e;
    const EXTCODEHASH_CODE = 0x3f;
    const BLOCKHASH_CODE = 0x40;
    const COINBASE_CODE = 0x41;
    const TIMESTAMP_CODE = 0x42;
    const NUMBER_CODE = 0x43;
    const DIFFICULTY_CODE = 0x44;
    const GASLIMIT_CODE = 0x45;
    const CHAINID_CODE = 0x46;
    const BASEFEE_CODE = 0x48;
    const POP_CODE = 0x50;
    const MLOAD_CODE = 0x51;
    const MSTORE_CODE = 0x52;
    const MSTORE8_CODE = 0x53;
    const SLOAD_CODE = 0x54;
    const SSTORE_CODE = 0x55;
    const JUMP_CODE = 0x56;
    const JUMPI_CODE = 0x57;
    const GETPC_CODE = 0x58;
    const MSIZE_CODE = 0x59;
    const GAS_CODE = 0x5a;
    const JUMPDEST_CODE = 0x5b;
    const PUSH1_CODE = 0x60;
    const PUSH2_CODE = 0x61;
    const PUSH3_CODE = 0x62;
    const PUSH4_CODE = 0x63;
    const PUSH5_CODE = 0x64;
    const PUSH6_CODE = 0x65;
    const PUSH7_CODE = 0x66;
    const PUSH8_CODE = 0x67;
    const PUSH9_CODE = 0x68;
    const PUSH10_CODE = 0x69;
    const PUSH11_CODE = 0x6a;
    const PUSH12_CODE = 0x6b;
    const PUSH13_CODE = 0x6c;
    const PUSH14_CODE = 0x6d;
    const PUSH15_CODE = 0x6e;
    const PUSH16_CODE = 0x6f;
    const PUSH17_CODE = 0x70;
    const PUSH18_CODE = 0x71;
    const PUSH19_CODE = 0x72;
    const PUSH20_CODE = 0x73;
    const PUSH21_CODE = 0x74;
    const PUSH22_CODE = 0x75;
    const PUSH23_CODE = 0x76;
    const PUSH24_CODE = 0x77;
    const PUSH25_CODE = 0x78;
    const PUSH26_CODE = 0x79;
    const PUSH27_CODE = 0x7a;
    const PUSH28_CODE = 0x7b;
    const PUSH29_CODE = 0x7c;
    const PUSH30_CODE = 0x7d;
    const PUSH31_CODE = 0x7e;
    const PUSH32_CODE = 0x7f;
    const DUP1_CODE = 0x80;
    const DUP2_CODE = 0x81;
    const DUP3_CODE = 0x82;
    const DUP4_CODE = 0x83;
    const DUP5_CODE = 0x84;
    const DUP6_CODE = 0x85;
    const DUP7_CODE = 0x86;
    const DUP8_CODE = 0x87;
    const DUP9_CODE = 0x88;
    const DUP10_CODE = 0x89;
    const DUP11_CODE = 0x8a;
    const DUP12_CODE = 0x8b;
    const DUP13_CODE = 0x8c;
    const DUP14_CODE = 0x8d;
    const DUP15_CODE = 0x8e;
    const DUP16_CODE = 0x8f;
    const SWAP1_CODE = 0x90;
    const SWAP2_CODE = 0x91;
    const SWAP3_CODE = 0x92;
    const SWAP4_CODE = 0x93;
    const SWAP5_CODE = 0x94;
    const SWAP6_CODE = 0x95;
    const SWAP7_CODE = 0x96;
    const SWAP8_CODE = 0x97;
    const SWAP9_CODE = 0x98;
    const SWAP10_CODE = 0x99;
    const SWAP11_CODE = 0x9a;
    const SWAP12_CODE = 0x9b;
    const SWAP13_CODE = 0x9c;
    const SWAP14_CODE = 0x9d;
    const SWAP15_CODE = 0x9e;
    const SWAP16_CODE = 0x9f;
    const LOG0_CODE = 0xa0;
    const LOG1_CODE = 0xa1;
    const LOG2_CODE = 0xa2;
    const LOG3_CODE = 0xa3;
    const LOG4_CODE = 0xa4;
    const JUMPTO_CODE = 0xb0;
    const JUMPIF_CODE = 0xb1;
    const JUMPSUB_CODE = 0xb2;
    const JUMPSUBV_CODE = 0xb4;
    const BEGINSUB_CODE = 0xb5;
    const BEGINDATA_CODE = 0xb6;
    const RETURNSUB_CODE = 0xb8;
    const PUTLOCAL_CODE = 0xb9;
    const GETLOCAL_CODE = 0xba;
    const SLOADBYTES_CODE = 0xe1;
    const SSTOREBYTES_CODE = 0xe2;
    const SSIZE_CODE = 0xe3;
    const CREATE_CODE = 0xf0;
    const CALL_CODE = 0xf1;
    const CALLCODE_CODE = 0xf2;
    const RETURN_CODE = 0xf3;
    const DELEGATECALL_CODE = 0xf4;
    const CREATE2_CODE = 0xf5;
    const STATICCALL_CODE = 0xfa;
    const TXEXECGAS_CODE = 0xfc;
    const REVERT_CODE = 0xfd;
    const INVALID_CODE = 0xfe;
    const SELFDESTRUCT_CODE = 0xff;

    func build() -> (opcodes: codeoffset*) {
        let (opcodes: codeoffset*) = alloc();
        assert opcodes[0] = STOP;
        assert opcodes[1] = ADD;
        assert opcodes[2] = MUL;
        return (opcodes=opcodes);
    }

    func execute{range_check_ptr, opcodes: codeoffset*, stack: StackStruct}(
        key: felt, n_args: felt, args: felt*
    ) {
        alloc_locals;
        let (__fp__, _) = get_fp_and_pc();
        let (location) = get_label_location(opcodes[key]);
        let (local all_args) = alloc();
        assert all_args[0] = range_check_ptr;
        memcpy(all_args + 1, cast(&stack, felt*), StackStruct.SIZE);
        memcpy(all_args + 1 + StackStruct.SIZE, args, n_args);
        let n_all_args = 1 + StackStruct.SIZE + n_args;
        invoke(location, n_all_args, all_args);
        let range_check_ptr = [ap - 3];
        let stack = StackStruct([ap - 2], cast([ap - 1], Uint256*));
        return ();
    }
}
