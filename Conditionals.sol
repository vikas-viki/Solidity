// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract conditionals {
    uint evenNum = 6;
    
    function isEvenTrue(uint _evenNum) public pure returns(string memory){
        if(_evenNum % 2 == 1){
            return "EvenNum is not an even number.";
        }else{
            return "EvenNum is correct.";
        }
    }
}