// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    uint256 public balance = 0;
    uint256 public loan = 0;
    uint256 public intrest = 12;
    uint256 public fdAmount = 0;
    uint256 public fdIntrest = 8;
    uint256 public fdYears = 0;
    address public user;

    constructor() {
        user = msg.sender;
    }

    function deposit(uint256 _amt) public returns (uint256) {
        balance = balance + _amt;
        return balance;
    }

    function withdraw(uint256 _amt) public returns (string memory) {
        if (_amt > balance) {
            loan = loan + (_amt - balance);
            balance = 0;
            return "Since blanace is not suffecient, you have got loan of";
        } else {
            balance = balance - _amt;
            return "You have successfully withdrawn";
        }
    }

    function getLoan(uint256 _amt) public returns (string memory) {
        if (_amt <= 20000) {
            loan = loan + _amt;
            return "You got loan Successfully @12% rate of intrest";
        } else {
            return "Loan amount is tooooo high.";
        }
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function createFD(uint256 _amt, uint256 _years)
        public
        returns (string memory)
    {
        if (_amt > balance) {
            return "Please deposit required amount of money to vreate a FD";
        } else if (fdAmount != 0) {
            return
                "You already have one FD, Our bank allows to create only one FD ata a time.";
        } else {
            fdAmount = _amt;
            fdYears = _years;
            return "FD created successfully";
        }
    }
}
