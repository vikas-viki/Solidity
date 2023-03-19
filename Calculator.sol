// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Calculator {


    function calculate(
        int _num1,
        int _num2,
        string memory _operator
    ) public pure returns (int256) {
        if (bytes(_operator).length == 0) { 
            revert("Empty operator");
        } else if (keccak256(bytes(_operator)) == keccak256("+")) {
            return _num1 + _num2;
        } else if (keccak256(bytes(_operator)) == keccak256("-")) {
            return _num1 - _num2;
        } else if (keccak256(bytes(_operator)) == keccak256("/")) {
            require(_num2 != 0, "Division by zero");
            return _num1 / _num2;
        } else if (keccak256(bytes(_operator)) == keccak256("*")) {
            return _num1 * _num2;
        } else {
            revert("Invalid operator");
        }
    }

}
