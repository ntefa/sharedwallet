pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable{
    
    using SafeMath for uint;
    mapping (address=>uint) public allowance;
    event allowanceChanged(address _who, uint _from, uint _to);
    
    function setAllowance(address _who, uint _amount) public onlyOwner{
    emit allowanceChanged(_who, allowance[_who], _amount);
    allowance[_who]=_amount;
    }
    
    function reduceAllowance(address _who, uint _amount) internal {
        allowance[_who]=allowance[_who].sub(_amount);
    }
    
    modifier allowed(uint _amount) {
        require(owner()==msg.sender || allowance[msg.sender]>=_amount,"You are not allowed");
        _;
    }

}