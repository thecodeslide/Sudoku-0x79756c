object "Sudoku_Yul_Ex_Stor" {
    code {
        mstore(0x40, 0x80)
        if callvalue() { revert(0, 0) }

        let _1 := copy_arguments_for_constructor_SudokuYulExStor()
        constructor_SudokuYulExStor(_1)
        datacopy(0, dataoffset("Sudoku_Yul_Ex_Stor_deployed"), datasize("Sudoku_Yul_Ex_Stor_deployed"))
        return(0, datasize("Sudoku_Yul_Ex_Stor_deployed"))

        function abi_decode_t_address_fromMemory(offset, end) -> value {
            value := mload(offset)
            validator_revert_t_address(value)
        }

        function abi_decode_tuple_t_address_fromMemory(headStart, dataEnd) -> value0 {
            if slt(sub(dataEnd, headStart), 0x20) { revert(0, 0) } {
                let offset := 0
                value0 := abi_decode_t_address_fromMemory(add(headStart, offset), dataEnd)
            }
        }

        function allocate_memory(size) -> mem {
            mem := mload(0x40)
            let mallocMem := add(mem, size)
            // protect against overflow
            if or(gt(mallocMem, 0xffffffffffffffff), lt(mallocMem, mem)) { revert(0, 0) }
            mstore(0x40, mallocMem)
        }

        function cleanup_t_address(value) -> cleaned {
            cleaned := cleanup_t_uint160(value)
        }

        function cleanup_t_uint160(value) -> cleaned {
            cleaned := and(value, 0xffffffffffffffffffffffffffffffffffffffff)
        }

        function constructor_SudokuYulExStor(libAddress) {
            let expr_11 := libAddress
            update_storage_value_offset_0t_lib$_LibrarySet_$905(0x00, expr_11)
        }

        function copy_arguments_for_constructor_SudokuYulExStor() -> ret_param_0 {
            let libSize := dataoffset("LIB_ADDRESS")
            let argSize := datasize("LIB_ADDRESS")

            let memoryDataOffset := allocate_memory(argSize)
            datacopy(memoryDataOffset, libSize, argSize)
            ret_param_0 := abi_decode_tuple_t_address_fromMemory(memoryDataOffset, add(memoryDataOffset, argSize))
        }

        function update_byte_slice_20_shift_0(value, toInsert) -> result {
            let mask := 0xffffffffffffffffffffffffffffffffffffffff
            value := and(value, not(mask))
            result := or(value, and(toInsert, mask))
        }

        function update_storage_value_offset_0t_lib$_LibrarySet_$905(slot, value) {
            sstore(slot, update_byte_slice_20_shift_0(sload(slot), value))
        }

        function validator_revert_t_address(value) {
            if iszero(eq(value, cleanup_t_address(value))) { revert(0, 0) }
        }
    }

    // placeholder address.
    data "LIB_ADDRESS" hex"000000000000000000000000deadbeefdeadbeefdeadbeefdeadbeefdeadbeef"
    
    object "Sudoku_Yul_Ex_Stor_deployed" {
        code {
            if callvalue() { revert(0, 0) } //fun____() stop()
            mstore(64, 128)

            if iszero(lt(calldatasize(), 4)) {
                let selector := shift_right_224_unsigned(calldataload(0))
                switch selector
                case 0x4ca6558a /* get_lib() */ { // getLib
                    abi_decode_tuple(4, calldatasize())
                    return_stuff(getter_fun_getLib())
                }
                case 0xf670d6d4 /* "fun_isValid(uint256[9][9])" */ {
                    abi_decode_tuple(4, calldatasize())
                    let cellValue //
                    let INDEX := 9
                    let sudokuBoard := 0x04
                    fun_isValid(cellValue, INDEX, sudokuBoard)
                    return_true()
                }

                case 0xcf608056 /* "fun_isValidBlocks(uint256[9][9])" */ {
                    abi_decode_tuple(4, calldatasize())
                    fun_isValidBlocks()                
                    return_true()
                }

                case 0xaea38760 /* "fun_isValidBlocks(uint256[9][9])" */ {
                    abi_decode_tuple(4, calldatasize())
                    fun_isValidCols()                
                    return_true()
                }

                case 0xed91ac90 /* "fun_isValidRows(uint256[9][9])" */ {
                    abi_decode_tuple(4, calldatasize())
                    fun_isValidRows()                
                    return_true()
                }
                
                case 0x7a8e73d3 { //setLib(address)
                    abi_decode_tuple(4, calldatasize())
                    let param_0 :=  abi_decode_tuple_t_address(4, calldatasize())
                    let slot := 0

                    set_lib_storage(slot, param_0)
                    return_true()
                }

                default { 
                    // revert(0, 0)
                }
            }

            if iszero(calldatasize()) {   }
            revert(0, 0)

            function abi_decode_t_address(offset, end) -> value {
                value := calldataload(offset)
                validator_revert_t_address(value)
            }

            function abi_decode_tuple(headStart, dataEnd)   {
                if slt(sub(dataEnd, headStart), 0) { revert(0, 0) }
            }

            function abi_decode_tuple_t_address(headStart, dataEnd) -> value0 {
                if slt(sub(dataEnd, headStart), 32) { revert(0, 0) }
                {
                    let offset := 0
                    value0 := abi_decode_t_address(add(headStart, offset), dataEnd)
                }
            }
            
            function abi_encode_t_stringliteral__fromStack(pos, value) {
                mstore(pos, value)
            }

            function abi_encode_errormessage__fromStack(headStart , value) -> tail { 
                tail := add(headStart, 32)
                abi_encode_t_stringliteral__fromStack(add(headStart, 0),  value)
            }

            function allocate_memory(size) -> mem {
                mem := mload(0x40)
                let mallocMem := add(mem, size)
                // protect against overflow
                if or(gt(mallocMem, 0xffffffffffffffff), lt(mallocMem, mem)) { revert(0, 0) }
                mstore(0x40, mallocMem)
            }

            // memory as storage
            function fun_isValid(cellValue, INDEX, sudokuBoard) {
                let _1 := allocate_memory(0x140)
                let rowList := _1
                mstore(rowList, add(_1, 0x20))

                let _2 := allocate_memory(320)
                let colList := _2
                mstore(colList, add(_2, 0x20))

                let _3 := allocate_memory(320)
                let blockList := _3
                mstore(blockList, add(_3, 0x20))

                for {let r := 0 } lt(r, 9) { r := add(r, 1)} {
                    for {let c := 0 } lt(c, 9) { c := add(c, 1)} {
                        cellValue := calldataload(add(add(mul(0x120, r), sudokuBoard), mul(0x20, c)))

                        if gt(cellValue, 9){
                            let memPos := allocate_memory(0)
                            let offset := 0x04
                            let argSize := 0x20
                            let _41 := 0xf
                            let _42 := "number too high" // 0x6e756d62657220746f6f2068696768
                            let _43 := abi_encode_errormessage__fromStack(add(memPos, offset), argSize)
                            let _44 := abi_encode_errormessage__fromStack(_43, _41)
                            
                            require_error(memPos, _44, add(_44, argSize), _42)
                        }

                        if gt(cellValue, 0) {
                            // we dont really use this but whatever
                            if gt(mul(cellValue, 0x20), mul(INDEX, 0x20)) {
                                let offset := 0x04
                                let errCode := 0x32
                                let tail := add(0, offset)
                                panic_error_0x4e487b71(0, tail, add(tail, 0x20), errCode)
                            }
                            let result := mload(add(mul(0x20, sub(cellValue, 1)), mload(rowList)))
                            let shifted := shl(mul(31,8),cellValue)

                            switch iszero(sub(result, shifted))
                            case 1 {
                                let mem := mload(0x40)
                                mstore(mem, hex"f3175e8b")
                                mstore(add(mem, 0x4),shifted)
                                mstore(add(mem, 0x24), hex"deadbeef")
                                revert(mem, 0x44)
                            }
                            default {
                                mstore(add(mload(rowList), mul(0x20, sub(cellValue, 1))), shifted)
                            }                        
                        } // endrow

                        cellValue := calldataload(add(add(mul(0x120, c), sudokuBoard), mul(0x20, r))) // cols

                        if gt(cellValue, 9){
                            let memPos := allocate_memory(0)
                            let offset := 0x04
                            let argSize := 0x20
                            let _36 := 0xf
                            let _37 := "number too high" // 0x6e756d62657220746f6f2068696768
                            let _33 := abi_encode_errormessage__fromStack(add(memPos, offset), argSize)
                            let _34 := abi_encode_errormessage__fromStack(_33, _36)
         
                            require_error(memPos, _34, add(_34, argSize), _37)
                        }

                        if gt(cellValue, 0) {
                            if gt(mul(cellValue, 0x20), mul(INDEX, 0x20)) {
                                let offset := 0x04
                                let errCode := 0x32
                                let tail := add(0, offset)
                                panic_error_0x4e487b71(allocate_memory(0), tail, add(tail, 0x20), errCode)
                            }

                            let result := mload(add(mul(0x20, sub(cellValue, 1)), mload(colList)))
                            let shifted := shl(mul(31,8),cellValue)

                            switch iszero(sub(result, shifted))
                            case 1 {
                                let mem := mload(0x40)
                                mstore(mem, hex"f3175e8b")
                                mstore(add(mem, 0x4),shifted)
                                mstore(add(mem, 0x24), hex"FDFDFDFD")
                                revert(mem, 0x44)
                            }
                            default {
                                mstore(add(mload(colList), mul(0x20, sub(cellValue, 1))), shifted)
                            }
                        } // endcol
                        
                        let i := add(mul(div(r, 3), 3) , div(c, 3))
                        let j := add(mul(mod(r,3), 3), mod(c, 3))

                        cellValue := calldataload(add(add(mul(0x120, i), sudokuBoard), mul(0x20, j))) // blocks

                        if gt(cellValue, 9){
                            let mem := mload(0x40) 
                            mstore(mem, hex"08c379a0")
                            mstore(add(mem, 0x4), 0x20)
                            mstore(add(mem, 0x24), 0xf)
                            mstore(add(mem, 0x44), "number too high")
                            revert(mem, 0x64)
                        }

                        if gt(cellValue, 0) {
                            if gt(mul(cellValue, 0x20), mul(INDEX, 0x20)) {
                                let offset := 0x04
                                let errCode := 0x32
                                let tail := add(0, offset)
                                panic_error_0x4e487b71(0, tail, add(tail, 0x20), errCode)
                            }
                            let result := mload(add(mul(0x20, sub(cellValue, 1)), mload(blockList)))
                            let shifted := shl(mul(31,8),cellValue)

                            // check duplicates
                            switch iszero(sub(result, shifted))
                            case 1 {
                                let mem := mload(0x40)
                                mstore(mem, hex"f3175e8b")
                                mstore(add(mem, 0x4),shifted)
                                mstore(add(mem, 0x24), hex"bebebebe")
                                revert(mem, 0x44)
                            }
                            default {
                                mstore(add(mload(blockList), mul(0x20, sub(cellValue, 1))), shifted)
                            }
                        }
                    } 
                    // reuse memory 
                    for { let i := 0 } lt(i, 9) {i := add(i, 1)} {
                        let mem := add(mload(rowList), mul(0x20, i))
                        // row
                        switch iszero(mload(mem))
                        case 0 {
                            mstore(mem, 0)
                            let val := mload(mem)
             
                            val := and(mul(exp(0x100, 0x1f), 0xff), val)
                            if gt(val, 0) {
                                let _5 := mload(0x40)
                                let offset := 0x04
                                let errCode := 0x01
                                let tail := add(_5, offset)
                                panic_error_0x4e487b71(_5, tail, add(tail, 0x20),  errCode)
                            }
                        }
                        default {    }
                        mem := add(mload(colList), mul(0x20, i))

                        switch iszero(mload(mem))
                        case 0 {
                            mstore(mem, 0)
                            let val := mload(mem)
                            val := and(mul(exp(0x100, 0x1f), 0xff), val)
                            if gt(val, 0) {
                                let _5 := mload(0x40)
                                let offset := 0x04
                                let errCode := 0x01
                                let tail := add(_5, offset)
                                panic_error_0x4e487b71(_5, tail, add(tail, 0x20), errCode)
                            }
                        }

                        mem := add(mload(blockList), mul(0x20, i))

                        switch iszero(mload(mem))
                        case 0 { // no
                            mstore(mem, 0)
                            let val := mload(mem)
        
                            val := and(mul(exp(0x100, 0x1f), 0xff), val)
                            if gt(val, 0) {
                                let _5 := mload(0x40)
                                let offset := 0x04
                                let errCode := 0x01
                                let tail := add(_5, offset)
                                panic_error_0x4e487b71(_5, tail, add(tail, 0x20), errCode)
                            }
                        }
                    }
                }
            }

            function fun_isValidBlocks()  {
                let blockNumber := 0
                let selector := hex"726a6a5f" 
                let resetselector := hex"0e305ba9"
                let sudokuBoard := 0x4

                revert_library_size_zero(extcodesize(getter_fun_getLib()))
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
                                    mstore(mem, hex"08c379a0")
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
                                            mstore(add(encoded, 0x4), seen_list_pos())
                                            mstore(add(encoded, 0x24), blockNumber)
                                            mstore(add(encoded, 0x44), "blocks")
                                            mstore(add(encoded, 0x64), cell)
                                            result := delegatecall(gas(), getter_fun_getLib(), encoded, 0x84, 0, 0)
                                        }
                                        default {
                                            mstore(add(encoded, 0x64), cell)
                                            result := delegatecall(gas(), getter_fun_getLib(), encoded, 0x84, 0, 0)
                                        }

                                        if iszero(result) {
                                            if gt(returndatasize(), 0) {
                                                revert_forward_1()
                                            }
                                            let mem := mload(0x40)
                                            mstore(mem, hex"08c379a0")
                                            mstore(add(mem, 0x4), 0x20)
                                            mstore(add(mem, 0x24), 0xc)
                                            mstore(add(mem, 0x44), "error insert")
                                            revert(mem, 0x64)
                                        }
                                    }
                                }
                            }
                        }
       
                        let memPos := memReset
    
                        if eq(mload(memPos), 0x0) { // todo
                            // skip mstore again
                            mstore(memPos, resetselector)
                            mstore(add(memPos, 0x4), seen_list_pos())
                            mstore(add(memPos, 0x24), blockNumber)
                        }

                        let result := delegatecall(gas(), getter_fun_getLib(), memPos, 0x44, 0, 0)

                        if iszero(result) {
                            if gt(returndatasize(), 0) {
                                {
                                    revert_forward_1()
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

            function fun_isValidRows()  {
                revert_library_size_zero(extcodesize(getter_fun_getLib()))
     
                let memInsert := allocate_memory(0x84)
                let memReset := allocate_memory(0x44)

                for {let r := 0} lt(r , 9) {  r:= add(r, 3)} {
                    insertListInner("rows", r, memInsert)
                    reset(r, memReset)
                }
            }

            function insertListInner(note, position, memLoc)  {
                let cellValue
                let insertSelector := hex"726a6a5f"

                for { let j := 0 } lt(j, 9) {j := add(j, 1)} {
                    switch note 
                    case "rows" {
                        cellValue := shl(248, calldataload(add(add(mul(0x120, position), 0x4) ,mul(0x20, j))))
                    }
                    default {
                        cellValue := shl(248, calldataload(add(add(mul(0x20, position), 0x4) ,mul(0x120, j))))
                    }

                    if gt(cellValue, hex"09") {
                        let mem := mload(0x40)

                        mstore(mem, shl(0xe5, 0x461bcd)) //Error string
                        mstore(add(mem, 0x04), 0x20)
                        mstore(add(mem, 0x24), 0x0f) 
                        mstore(add(mem, 0x44), "number too high")
                        revert(mem, 0x64)
                    }

                    if gt(cellValue, 0) {
                        let frame := memLoc
                        mstore(frame, insertSelector)
                        mstore(add(frame, 0x4), seen_list_pos())
                        mstore(add(frame, 0x24), position)
                        mstore(add(frame, 0x44), note)
                        mstore(add(frame, 0x64), cellValue)
                        
                        let result := delegatecall(gas(), getter_fun_getLib(), frame, 0x84, 0, 0)

                        if iszero(result) {
                            if gt(returndatasize(), 0) {
                                revert_forward_1()
                            }

                            let mem := mload(0x40)
                            mstore(mem, hex"08c379a0") //Error string
                            mstore(add(mem, 0x4), 0x20)
                            mstore(add(mem, 0x24), 0xc)
                            mstore(add(mem, 0x44), "error result")
                            revert(mem, 0x64)
                        }
                    }
                }

            }

             function fun_isValidCols()  {
                revert_library_size_zero(extcodesize(getter_fun_getLib()))
                let memInsert := allocate_memory(0x84)
                let memReset := allocate_memory(0x44)

                for {let i := 0} lt(i , 9) {  i:= add(i, 3)} {
                    insertListInner("cols", i, memInsert)
                    reset(i, memReset)
                }
            }

            function reset(key, memLoc) {
                let resetselector := hex"0e305ba9"
                let memPos := memLoc

                mstore(memPos, resetselector)
                mstore(add(memPos, 0x4), seen_list_pos())
                mstore(add(memPos, 0x24), key)
                let result := delegatecall(gas(), getter_fun_getLib(), memPos, 0x44, 0, 0)

                if iszero(result) {
                    if gt(returndatasize(), 0) {
                        {
                            revert_forward_1()
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

            function cleanup_t_address(value) -> cleaned {
                cleaned := cleanup_t_uint160(value)
            }

            function cleanup_t_uint160(value) -> cleaned {
                cleaned := and(value, 0xffffffffffffffffffffffffffffffffffffffff)
            }

            function getter_fun_getLib() -> addr { // TODO
                let slot := 0
                addr  := sload(lib_address_pos(slot))
            }

            function get_seen_list() -> seen {
                seen := sload(seen_list_pos())
            }

            function set_lib_storage(key, val)  {
                sstore(lib_address_pos(key), val)
            }

            function return_stuff(v) {
                mstore(0, v)
                return(0, 0x20)
            }

            function return_true() {
                return_stuff(1)
            }

            function shift_right_224_unsigned(value) -> newValue {
                newValue := shr(224, value)
            }

            function round_up_to_mul_of_32(value) -> result {
                result := and(add(value, 31), not(31))
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

            function panic_error_0x4e487b71(headStart, offset, argSize, errCode) {
                mstore(headStart, hex"4e487b71")
                mstore(offset, errCode)

                revert(headStart, argSize)
            }

            function require_error(headStart, offset, argSize, errMessage) {
                mstore(headStart, hex"08c379a0")
                mstore(offset, errMessage)

                revert(headStart, sub(argSize, headStart))
            }

            function revert_forward_1() {
                let pos := mload(0x40)
                returndatacopy(pos, 0, returndatasize())
                revert(pos, returndatasize())
            }

            function validator_revert_t_address(value) {
                if iszero(eq(value, cleanup_t_address(value))) { revert(0, 0) }
            }

            function lib_address_pos(key) -> p { p := key }
            function seen_list_pos() -> p { p := 1 }
            
        } // endcode
    }
}
