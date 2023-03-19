// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.8.2/contracts/token/ERC20/ERC20.sol";

contract MineToken is ERC20 {
    constructor(uint256 _initialSupply) ERC20("MineToken", "MNT") {
        _mint(msg.sender, _initialSupply);
    }
}