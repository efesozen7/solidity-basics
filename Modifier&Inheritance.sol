//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;

contract Parent{
    
    address payable owner;
    constructor() public {
        owner = msg.sender;
    }
    modifier req{
        require(msg.sender == owner, "You are not authorized to use this functionality.");
        _;
        
    } 
}

contract Child is Parent{
    uint public totalBalance;
    function getBalance() public view returns(uint){
        totalBalance;
    }
    function receiveFunds() public payable{
        totalBalance += msg.value;
    }
    function withdrawFunds(uint _amount) public req {
        require(totalBalance >= _amount);
        owner.transfer(_amount);
        totalBalance-=_amount;
    }
    
    receive() external payable{
        receiveFunds();
    }
}