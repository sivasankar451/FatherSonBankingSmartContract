pragma solidity >=0.5.0 <0.6.0;

import "./ownable.sol";
import "./safemath.sol";

contract Banking is Ownable{
    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    uint public fatherBalance = 0;
    uint public childBalance = 0;
    address public childAddress;

    function assignChild(address _childAddress) external onlyOwner{
        childAddress = _childAddress;
    }

    function deposit(uint amount) external onlyOwner{
        fatherBalance += amount;
    }

    function withdraw(uint _amount) external onlyChild withDrawalLimit(_amount){
        fatherBalance -= _amount;
        childBalance += _amount;
    }
    

    modifier onlyChild(){
        require(msg.sender == childAddress, "Only child is allowed to perform this action");
        _;
    }

    modifier withDrawalLimit(uint _amount){
        require(_amount <= 1000, "Balance should be <= 1000");
        require(_amount < fatherBalance, "No sufficient balance");
        _;
    }

}