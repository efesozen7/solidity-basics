pragma solidity ^0.5.11;

contract Variables{
    string public myString = "Hello World";
    uint256 public myUint;
    bool public myBool;
    
    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }
    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }
    
    uint8 public myUint8;
    //integers can wrap around.
    function incrementUint() public{
        myUint8++;
    }
    function decrementUint() public {
        myUint8--;
    }
    
    //20byte long ethereum account addresses
    address public myAddress;
    function setAddress(address _address) public{
        myAddress = _address;
    }
    
    function getBalanceOfAddress() public view returns(uint){
        return myAddress.balance;
    }
  
    
    string public str = "fck";
    
    function setMyString(string memory _myString) public{
        str = _myString;
    }
}