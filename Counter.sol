// SPDX-License-Identifier: MIT
// link to docs: https://docs.soliditylang.org/
// Specifying the version of solidity to use
pragma solidity ^0.8.0;

// Creating a contract.
contract counter {
    // making it public it will be availaibe outside contract also.
    uint public count;

    // Runs every time when contract is created (Initialized).
    constructor(){
        count = 0;
    }

    // Read function: Con't change any value in BChain (No gas to pay).
    function getCount() public view returns(uint){
        return count;
    }
    // Read function: Changes one of value in BChain (Gas to pay).
    function incrementCount() public {
        count++;
    }
    // Read function: Changes one of value in BChain (Gas to pay).
    function decrementCount() public {
        count--;
    }
}