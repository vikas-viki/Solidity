// SPDX-License-Identifier: MIT

// 0x8E4275cfE5Fa615db56bDEcFcdDD1a6268F3e4E7 
pragma solidity ^0.8.0;

contract Bank {
    uint public balance;
    uint public loan;
    constructor(uint _initialDeposit) {
        balance = _initialDeposit;
    }

    function deposit (uint _money) public{
        balance = balance + _money;
    } 
    function withdraw (uint _money) public returns(string memory){
        if(_money > balance){
            return "Not enough balance";
        }else{
            balance = balance - _money;
            return "successful";
        }
    } 
    function getLoan(uint _money) public{
        balance = balance +  _money;
        loan = loan + _money;
    }
    function getBalance() public view returns(uint){
        return balance;
    }
    function ret_str() public pure returns(string memory){
        return "value";
    }
}