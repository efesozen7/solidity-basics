pragma solidity ^0.5.11;

contract Addresses{
    //storing balance could be a problem if forgotten to be updated.
    //while received money is still 5ETH, balance of contract is 0ETH since we have withdrawn all the funds.
    uint public balanceReceived;
    //lock the funds using a timestamp
    uint public lockedUntil;
    
    address payable ownerOfContract;
    bool paused;
    
    constructor() public{
         ownerOfContract = msg.sender;
    }
    
    function receiveMoney() public payable{
        balanceReceived += msg.value;    
        lockedUntil = block.timestamp + 1 minutes;
    }
    function balanceOfContract() public view returns(uint){
        return address(this).balance;
    }
    function setPaused(bool _paused) public{
        require(msg.sender == ownerOfContract);
        paused = _paused;
    }
    function withdrawMoney() public {
        //if(lockedUntil<block.timestamp){
            
            ownerOfContract.transfer(this.balanceOfContract());
        //}
    }
    function withdrawMoneyAddress(address payable _address) public{
       // if(lockedUntil <block.timestamp){
           require(msg.sender == ownerOfContract, "You are not the owner");
           require(!paused, "this contract is paused");
        _address.transfer(this.balanceOfContract());
        //}
            
        } 
    function destroySmartContract() public {
        require(msg.sender == ownerOfContract, "You are not the owner");
        selfdestruct(ownerOfContract);
    }
}
