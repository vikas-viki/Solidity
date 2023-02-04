// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    address owner;

    modifier isOwner() {
        require(msg.sender == owner, "Owner only can access secret.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }
}

contract SecretVault {
    string secret;

    constructor(string memory _sec) {
        secret = _sec;
    }

    function getSecret() public view returns (string memory) {
        return secret;
    }
}

// inhering the Ownable contract using 'is' keyword.
contract MyContract is Ownable {
    address public secretvault;


    constructor(string memory _sec) {

        SecretVault sec = new SecretVault(_sec);

        secretvault = address(sec);
        // Importing the states/props from the parent contract.
        super;
    }

    function getSecret() public view isOwner returns (string memory) {
        return SecretVault(secretvault).getSecret();
    }
}
