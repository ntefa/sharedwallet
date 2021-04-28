pragma solidity ^0.8.0;

import "./Allowance.sol";

contract Wallet is Allowance{
   
    event moneyadded(uint _amount);
    event withdrawal(address _who, uint _amount);

    function renounceOwnership() public override {
    }
    
    function withdrawMoney(address payable _to,uint _amount) public allowed(_amount){
        require(address(this).balance>=_amount,"Not enough money");
        emit withdrawal(_to,_amount);
        _to.transfer(_amount);
        
        if (msg.sender!=owner()) {
            reduceAllowance(_to,_amount);
        }
    }
    
    receive() external payable {
        emit moneyadded(msg.value); 
    }
    
}
