object "SudokuYulStor" {
    code {
        datacopy(0, dataoffset("runtime"), datasize("runtime"))
        return(0, datasize("runtime"))
    }

    object "runtime" {
        code {
            mstore(64, 128)
            if iszero(lt(calldatasize(), 4)) {
                let selector := shift_right_224_unsigned(calldataload(0))
                switch selector
                case 0x0e3d9299 /* "transfer(address,uint256)" */ { // getLib
                    returnStuff(get_lib())
                }
                case 0xcf608056 /* fun_isValidBlocks(uint256[9][9]) */ {
                    fun_isValidBlocks()                
                    returnTrue()
                }
                case 0x7a8e73d3 { //setLib(address)
                    set_lib_storage()
                    returnTrue()
                }
                default {
                    revert(0, 0)
                }
            }

            function fun_isValidBlocks()  {
                let blockNumber := 0
                let selector := hex"726a6a5f"
                let resetselector := hex"0e305ba9"
                let sudokuBoard := 0x4
       
                revert_library_size_zero(extcodesize(get_lib()))
                let memInsert := allocate_memory(0x84)
                let memReset := allocate_memory(0x44)

                for {let r := 0} lt(r , 9) {  r:= add(r, 3)} {
                    for {let c := 0} lt(c , 9) { c := add(c, 3)} {

                    let _i := add(r, 3)
                    let _j := add(c, 3)

                    for { let i := r} lt(i , _i) { i := add(i, 1)} {
                        for { let j := c} lt(j , _j) { j := add(j, 1)} {

                            let cell := shl(248, calldataload(add(add(mul(0x120, i), sudokuBoard), mul(0x20, j))))

                            if gt(cell, hex"09") {
                                let mem := mload(0x40)
                                mstore(mem, hex"08c379a0") // Error string
                                mstore(add(mem, 0x4), 0x20)
                                mstore(add(mem, 0x24), 0xf)
                                mstore(add(mem, 0x44), "number too high")
                                revert(mem, 0x64)
                            }

                            if gt(cell, 0){
                                let encoded := memInsert
                                let result 
                                {
                                    switch gt(mload(encoded), 0x0)
                                    case 0x0 {
                                        mstore(encoded, selector)
                                        mstore(add(encoded, 0x4), seenListPos())
                                        mstore(add(encoded, 0x24), blockNumber)
                                        mstore(add(encoded, 0x44), "blocks")
                                        mstore(add(encoded, 0x64), cell)
                                        result := delegatecall(gas(), get_lib(), encoded, 0x84, 0, 0)
                                    }
                                    default {
                                        mstore(add(encoded, 0x64), cell)
                                        result := delegatecall(gas(), get_lib(), encoded, 0x84, 0, 0)
                                    }

                                    if iszero(result) {
                                        if gt(returndatasize(), 0) {
                                            let pos := mload(0x40)
                                            returndatacopy(pos, 0, returndatasize())
                                            revert(pos, returndatasize())
                                        }
                                        let mem := mload(0x40)
                                        mstore(mem, hex"08c379a0")
                                        mstore(add(mem, 0x4), 0x20) // offset
                                        mstore(add(mem, 0x24), 0xc)
                                        mstore(add(mem, 0x44), "error insert")
                                        revert(mem, 0x64)
                                    }
                                }
                            }
                        }
                    }

                    let memPos := memReset
                    if eq(mload(memPos), 0x0) {
                        // skip mstore again
                        mstore(memPos, resetselector)
                        mstore(add(memPos, 0x4), seenListPos())
                        mstore(add(memPos, 0x24), blockNumber)
                    }

                    let result := delegatecall(gas(), get_lib(), memPos, 0x44, 0, 0)

                    if iszero(result) {
                        if gt(returndatasize(), 0) {
                            let pos := mload(0x40)
                            {
                                returndatacopy(pos, 0, returndatasize())
                                revert(pos, returndatasize()) 
                            }
                        }
                        let mem := mload(0x40)
                        mstore(mem, hex"08c379a0")
                        mstore(add(mem, 0x4), 0x20)
                        mstore(add(mem, 0x24), 0xb)
                        mstore(add(mem, 0x44), "error reset")
                        revert(mem, 0x64)
                    }
                    }
                }
            }

            function allocate_memory(size) -> mem {
                mem := mload(0x40)
                let mallocMem := add(mem, size)
                // protect against overflow
                if or(gt(mallocMem, 0xffffffffffffffff), lt(mallocMem, mem)) { revert(0, 0) }
                mstore(0x40, mallocMem)
            }

            function get_lib() -> addr {
                addr  := sload(libAddressPos())
            }

            function getSeenList() -> seen {
                seen := sload(seenListPos())
            }

            function set_lib_storage()  {
                sstore(libAddressPos(), calldataload(0x4))
            }

            function returnStuff(v) {
                mstore(0, v)
                return(0, 0x20)
            }

            function returnTrue() {
                returnStuff(1)
            }

            function shift_right_224_unsigned(value) -> newValue {
                newValue := shr(224, value)
            }

            function revert_library_size_zero(addr) {
                revert_library_err0r(addr)
            }

            function revert_library_err0r(condition) {
                if iszero(condition) {
                    let mem := mload(0x40)
                    mstore(mem, hex"08c379a0")
                    mstore(add(mem, 0x4), 0x20)
                    mstore(add(mem, 0x24), 0xd)
                    mstore(add(mem, 0x44), "error library")
                    revert(mem, 0x64)
                }
            }

            function revert_forward_1() {
                returndatacopy(0, 0, returndatasize())
                revert(0, returndatasize())
            }

            function round_up_to_mul_of_32(value) -> result {
                result := and(add(value, 31), not(31))
            }

            function libAddressPos() -> p { p := 0 }
            function seenListPos() -> p { p := 1 }
           
        } //endcode
    }
}
