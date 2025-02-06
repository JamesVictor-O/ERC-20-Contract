// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;


import "./ERC20Contract.sol";

contract PiggyBankContract{
     
     ERC20 public token;
  
    constructor(address _erc20Address){
        token=ERC20(_erc20Address);
    }

    uint private savedTokens;
    event Deposited(address depositor, uint amount);
    event Withdraw(address withdrawer, uint amount);


    function depositToSavingsContract(uint _savingsAmount) external {
        require(_savingsAmount > 21000, "Insufficient Tokens");
         require(token.transferFrom(msg.sender, address(this), _savingsAmount), "Transfer Failed");
         savedTokens += _savingsAmount;

         emit Deposited(msg.sender, _savingsAmount);
    }

    function withdrawToken(uint _amount) external  {
         require(savedTokens  >= _amount, "Insuficient SavedToken");
         require(token.transfer(msg.sender, _amount), "Transfer Failed");
         savedTokens -= _amount;
         emit Withdraw(msg.sender, _amount);
    }
    
    function getTokenBalance() public view returns(uint) {
        return savedTokens;
    }

}
