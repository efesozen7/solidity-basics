pragma solidity ^0.5.11;

contract Maps {
  mapping(uint => bool) public map;
  mapping(address => bool) public addressMap;
  mapping(address => Balance) public balanceReceived;
  
  struct Payment {
      uint amount;
      uint timestamp;
  }
  
  struct Balance{
     uint totalBalance;
     uint numPayments;
     mapping(uint => Payment) payments;
  }
  function setValue(uint _index, bool boolean) public {
      map[_index] = boolean;
  }
  
  function setMyAddressToTrue() public {
      addressMap[msg.sender] = true;
  }
  
  function getBalance() public view returns(uint){
      return address(this).balance;
  }
  function sendMoney() public payable{
      balanceReceived[msg.sender].totalBalance += msg.value;
      
      Payment memory payment  = Payment(msg.value, now);
      
      balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;
      balanceReceived[msg.sender].numPayments++;

  }
  function withdrawMoney(address payable _to, uint _amount) public {
      require(balanceReceived[msg.sender].totalBalance >= _amount);
      balanceReceived[msg.sender].totalBalance -= _amount;
      _to.transfer(_amount);
     
  }
  function withdrawAllMoney(address payable _to) public{
      uint balanceToSend = balanceReceived[msg.sender].totalBalance;
      balanceReceived[msg.sender].totalBalance = 0; 
      _to.transfer(balanceToSend);
  }
}