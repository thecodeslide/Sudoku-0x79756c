library SetSudokuLib {
  struct Set  {
    uint8[9]  values;
    mapping (bytes1 => bytes1) has;
  }

  struct Set2 {
    bytes1[9]  values; 
    // bytes1[9]  values2;
  }

  error duplicateError(bytes1, bytes32 , bytes4);
  error duplicateError2(bytes1, bytes4);
  event CalledSuccessfully(bytes1 param2);

  function contains(Set storage set, uint key, bytes1 cellValue) public view returns(bytes1 result) {
    assembly {
      mstore(0, key)
      mstore(0x20, set.slot)
      result := sload(keccak256(0, 0x40))
   
      let val := mod(cellValue, 0xff)
      let position := shl(mul(val, 8), val)
      position := and(position, mul(exp(0x100, val), 0xff))
      if and(result, position) {
        result := hex"01"
      }
    }
  }
  
  function insert(Set storage set, uint key, bytes32 action, bytes1 cellValue) external {
    if (contains(set, key, cellValue) == hex'01') revert duplicateError(cellValue, action, hex'DEADBEEF');

    assembly {
      mstore(0, key)
      mstore(0x20, set.slot)
 
      let shifted := mod( cellValue, 0xff )
      let position := shl( mul( shifted, 8 ), shifted) 
      let result :=  and( mul( exp( 0x100, shifted ) , 0xff ) , position )
      let mask := not(mul(exp(0x0100, shifted), 0xff))
      result := or(and(mask, sload(keccak256(0, 0x40))), result)
      sstore(keccak256(0, 0x40), result)
    }
  }

  
  function reset(Set storage set, uint key) public {
    assembly {
      mstore(0, key)
      mstore(0x20, set.slot)
      let hash:= keccak256(0, 0x40)
      
      if sload(hash) {
        sstore(hash, 0)
        let _hash := sload(hash)

        let mask := not(mul(0xff, exp(0x100, 0x1f)))
        _hash := and(mask, _hash)

        if or(_hash, sload(hash)) {
          let frame := mload(0x40)
          mstore(frame, hex"4e487b71") 
          mstore(add(frame, 0x4), 1)
          revert(frame, 0x24)
        }
      }
  }

  function setSlot(Set storage set, bytes32 _slot) external pure {
    assembly {
      mstore(0, _slot)
      set.slot := keccak256(0,0x20)
    }
  }
}
