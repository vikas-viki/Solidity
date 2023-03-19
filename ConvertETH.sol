// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ConnvertETH{
    uint256 public _weiEquivalent;
    uint256 public _gweiEquivalent;
    uint256 public _etherEquivalent;

    function getAmount() payable public{
        _weiEquivalent = msg.value * 1 wei;
        _gweiEquivalent = msg.value * 1 gwei;
        _etherEquivalent = msg.value * 1 ether;
    }

}