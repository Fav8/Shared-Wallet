pragma solidity ^0.8.0;
/*specifiche:
A shared wallet where people can deposit money and the owner decides their allowance, basically how much they can spend.
*/
contract SharedWallet{
    address public owner;
    constructor(){
        owner = msg.sender;
    }
    
    mapping ( address => uint) allowance;
    
    function sendMoney() public payable {
    }
    function withdrawMoney(address payable _to, uint _amount) public {
        if(msg.sender != owner){
            require(allowance[msg.sender] >= _amount , "non hai allowance");
        }
        allowance[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    function setAllowance(address _of, uint _amount) public {
        require(owner == msg.sender , "chiedi il permesso");
        allowance[_of] = _amount;
    }
    receive() external payable{
        sendMoney();
    }
}