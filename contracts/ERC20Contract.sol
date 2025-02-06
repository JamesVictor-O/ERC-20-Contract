// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract ERC20 {

// this maps each account address to a unit, which repersent the number  of token owned bt the account
mapping(address => uint256) private  _balances;


//    This is a nested mapping that stores the allowances granted by token holders to other addresses

   mapping (address => mapping (address => uint256)) private _allowance;

   uint256 private _totalSupply;

   string private _name;
   string private _symbol;
   address public _owner;

   constructor(string memory name_, string memory symbol_){
          _name=name_;
          _symbol=symbol_;
          _owner=msg.sender;
   }

    //  Events
    event Approval(address indexed owner, address indexed spender, uint256 value);
   event Transfer(address indexed from, address indexed to, uint256 value);
   event MintToken(address indexed minter,  uint256 amountMinted);

    // _________________________Public view functions___________________________________

   function getTokenName()public view returns (string memory){
     return _name;
   }

   function getTokenSymbol()public view returns(string memory){
      return  _symbol;
   }
    
   function getDecimals() public view  virtual returns(uint8){
     return 18;
   }

   function totalSupply() public view virtual returns(uint256){
       return  _totalSupply;
   }

//   function _msgSender() internal view returns (address) {
//     return msg.sender;
// }


// this function return the token balance of a specific adress from the _balance mapping
// Allows external contracts or users to query the balance of any address
 function balanceOf(address account) public view virtual returns(uint){
    return _balances[account];
 }


//  Returns the remaining allowance that a spender can use on behalf of an owner that is the amount of token allocated to him. 

function allowance(address owner, address spender) public virtual view returns(uint){
     return _allowance[owner][spender];
}



//    ________________________public  state-changing function________________________________________


// Transfers tokens from the caller’s address to another address
//  Allows users to send tokens to others 

  function transfer( address receiver, uint value) public virtual returns(bool){
      address sender=msg.sender;
      _transfer(sender, receiver, value);
      return true;
  }
//  Transfers tokens on behalf of an owner (if the caller has sufficient allowance).
// Allows delegated transfers (e.g., for decentralized exchanges).

   function transferFrom(address from, address to, uint value) public virtual returns(bool){
      address spender=msg.sender;
      _spendAllowance(from, spender, value);
      _transfer(from, to, value);
      return true;
   }







 


   function mintToken(uint _amountOfToken) public {
       require(msg.sender == _owner, "Only the owner");
       _totalSupply += _amountOfToken;

      emit MintToken(msg.sender, _amountOfToken);
   }
// __________________helper function_______________________________________


// this handles the logic for transferring tokens between two address
//  Ensures that transfers are valid and updates balances

   function _transfer(address from, address to, uint amount)internal {  
        require(from != address(0), "Invalid sender");
        require(to != address(0), "Invalid Reciver");

         uint256 fromBalance = _balances[from];

         require(fromBalance >= amount, "Insufficient balance");

         unchecked {
            _balances[from] = fromBalance - amount;
         }
         _balances[to] += amount;

         emit Transfer(from, to, amount);
   }



    // Approves a spender to spend a specific amount of tokens on behalf of an owner
    // Enables delegated transfers.

   function _approve(address owner, address spender, uint value, bool emitEvent) public virtual{
       require(owner != address(0), "Invalid owner Account");
       require(spender != address(0), "Invalid spender account");
       _allowance[owner][spender]=value;

       if(emitEvent){
        emit Approval(owner,spender,value);
       }
   }



    //  Deducts the allowance when a spender uses it.
    //  Ensures that spenders cannot exceed their approved allowance.

   function _spendAllowance(address owner, address spender, uint256 value) internal virtual{
     uint256 currentAllowance= allowance(owner, spender);

     require(currentAllowance >= value, "Insufficient Balance");
      unchecked{
        _approve(owner, spender, currentAllowance-value, false);
      }
   }
}

