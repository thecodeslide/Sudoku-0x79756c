// SPDX-License-Identifier:NON-AI AGPL-3.0-only
pragma solidity ^0.8.17;

// interface solidity contract will use to call Yul contract
interface ISudokuYulBuildSpace {
    function fun_isValidBlocks(uint256[9][9] calldata board) external returns (uint256);
    function fun_isValidRows(uint256[9][9] calldata board) external returns (uint256);
    function fun_isValidCols(uint256[9][9] calldata board) external returns (uint256);
    function fun_isValid(uint256[9][9] calldata board) external returns (uint256);
    function get_lib() external returns (address);
    function set_lib(address addr) external returns (uint);
}
contract CallSudokuYulExStor {
    ISudokuYulExStor public target;

    constructor(ISudokuYulExStor _target) {
        target = _target;
    }
    
    function isValid(uint256[9][9] calldata board) external returns (uint256) {
        return target.fun_isValid(board);
    }
    
    function validBlock(uint256[9][9] calldata board) external returns (uint256) {
        return target.fun_isValidBlocks(board);
    }

    function validCols(uint256[9][9] calldata board) external returns (uint256) {
        return target.fun_isValidCols(board);
    }

    function validRows(uint256[9][9] calldata board) external returns (uint256) {
        return target.fun_isValidRows(board);
    }

    function getLibAddr() public  returns (address) {
        return target.get_lib();
    }

    function setLib(address addr) external returns (uint) {
        return target.set_lib(addr);
    }
}
