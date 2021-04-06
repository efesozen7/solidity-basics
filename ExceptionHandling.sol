pragma solidity ^0.5.13;

contract ExceptionHandling{
    
    mapping(address=> uint) public balanceReceived;
    
    function receiveMoney() public payable {
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }
    
    function withdrawMoney(address payable _to, uint64 _amount) public {
        //input validation - require
        assert(balanceReceived[msg.sender] <= balanceReceived[msg.sender] - _amount);
  
        //assert is for checking internal variable states.
        //when an error is thrown, all the transactions made before are reverted. 
        //assert consumes all the gas money within the contract
        //require gives back the remaining amount of gas 
  
            balanceReceived[msg.sender] -=_amount;
            _to.transfer(_amount);
        
    }
}
    