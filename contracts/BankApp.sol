// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract BankApp {
    address owner;
    struct db {
        address accountNumber;
        uint256 balance;
        bool blackList;
    }
    constructor(){
        owner=msg.sender;
    }
    modifier onlyOwner() {
        require(
            msg.sender == account[msg.sender].accountNumber,
            "there is no account"
            
        );
                require(!systemoverloaded,"Error, please try later for processing");

        _;
    }
    
bool systemoverloaded;  // standart olarak false value takes
    mapping(address => db) account;

    function deposit() public payable {
        require(!systemoverloaded,"Error, please try later for processing");
        if(account[msg.sender].blackList){
 revert("Blocked ur account ");
        }else{ 

            account[msg.sender].balance += msg.value;
        account[msg.sender].accountNumber = msg.sender;}
       
      
    }
    function systemShutDown() public {
                 require(msg.sender==owner,"you don't have any authorization");

        systemoverloaded = !systemoverloaded;
    }

    function balanceOf() public view onlyOwner returns (uint256) {
        //  require(msg.sender==account[msg.sender].accountNumber,"There is no account");
        return account[msg.sender].balance;
    }

    function withdrawals(address payable _to, uint256 _amount)
        public
        onlyOwner
    {
        require(account[msg.sender].balance >= _amount, "Insufficient balance");
        //  require(msg.sender==account[msg.sender].accountNumber,"There is no account");
        account[msg.sender].balance -= _amount;
        _to.transfer(_amount);
    }

    function bankWireTransfer(address payable _to, uint256 _amount) public {
        require(account[msg.sender].balance>=_amount,"Insufficient balance");
        require(_to == account[_to].accountNumber,"there is no client in bank ");
        require(_to != msg.sender, "cannot transfer self");
        _to.transfer(_amount);
        account[msg.sender].balance -= _amount;
        account[_to].balance+=_amount;
        
    }



    function fastTransfer(address payable _to, uint256 _amount) public {
        require(account[msg.sender].balance>=_amount,"Insufficient balance");
        require(_to != account[_to].accountNumber,"Customer of our bank, you can transfer");
        _to.transfer(_amount);
        account[msg.sender].balance -= _amount;
        account[_to].balance+=_amount;
        
    }

    function blackListAdd(address _to) public {
         require(msg.sender==owner,"you don't have any authorization");
         account[_to].blackList = true;
    }

   
}
