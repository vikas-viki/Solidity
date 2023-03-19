// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Constants{
    int public constant a = 123;

    constructor(int _val){
        a = _val;
    }
}