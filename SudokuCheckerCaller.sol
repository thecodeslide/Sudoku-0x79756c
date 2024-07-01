// SPDX-License-Identifier:NON-AI AGPL-3.0-only
pragma solidity ^0.8.17;

// interface solidity contract will use to call Yul contract
interface ISudokuYulExStor {
    function fun_isValidBlocks(uint256[9][9] calldata board) external returns (uint256);
    function get_lib() external returns (address);
    function set_lib(address addr) external returns (uint);
}

contract CallSudokuYulExStor {
    ISudokuYulExStor public target;

    constructor(ISudokuYulExStor _target) {
        target = _target;
    }
    
    function validBlock(uint256[9][9] calldata board) external returns (uint256) {
        return target.fun_isValidBlocks(board); // cf608056
    }

    function getLibAddr() public  returns (address) {
        return target.get_lib();
    }

    function setLib(address addr) external returns (uint) { // 245cba0a
        return target.set_lib(addr);
    }
}
