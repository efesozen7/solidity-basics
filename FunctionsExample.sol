//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

contract ExceptionHandling{
    
    //storage (instance) variables
    mapping(address=> uint) public balanceReceived;
    address payable owner;
    
    constructor() public{
        //owner becomes the person that deployed the smart contract
        owner = msg.sender;
    }
    
    //getter is used with view
    function getOwner() public view returns(address){
        return owner;
    }
    
    //pure function - does not interact with storage variables.
    function convertFromWeiToEther(uint _wei) public pure returns(uint){
        return _wei / (1 ether);
    }
    
    function destroyContract() public{
        require(msg.sender == owner);
        selfdestruct(owner);
    }
    
    function receiveMoney() public payable {
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }
    
    function withdrawMoney(address payable _to, uint _amount) public {
        assert(balanceReceived[msg.sender] <= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -=_amount;
        _to.transfer(_amount);
    }
    
    //receive function
    //only invoked when money is sent to the contract or when a function is called within the contract,
    //but the name of the function is misspelled
    receive () external payable{
        receiveMoney(); 
    }
     //receive function
    //only invoked when money is NOT sent to the contract and when a function is called within the contract,
    //but the name of the function is misspelled
    fallback() external{
        
    }
    
    //view and pure functions are Reading functions,
    //There is no need to create a transaction and mine this transaction to make this call to the 
    // reading functions possible, because you already contain the data within your local storage (storing the blockchain).
    
    //writing functions however, will make changes in your smart contracts (not the code, but there will be transactions),
    //therefore, gas money is needed to create these transactions and execute them, because these transactions have to be confirmed by.
    //mining.
    
    
    //public -> can be called internally and externally
    //external -> can be called from other contracts and externally (not internally!)
    //private -> can be called only within the contracts
    //internal -> only from the contract or derived contracts(?) (allows inheritance)
    
}
    