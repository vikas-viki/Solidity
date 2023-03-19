// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom {
    // Shows the indexes. If vacant return 0 else 1.
    enum status {
        Vacant,
        Occupied
    }
    status public currentStatus;

    // Events in solidity.
    event occupies(address _name, uint256 _amount);

    // Working with ethers like paying and recieving only possible if the address is specified as payable.
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
        currentStatus = status.Vacant;
    }

    // Modifiers are like middlewares in nodejs.
    // Increases re-useability, keeping code cleaner.
    modifier onlyIfVacant() {
        require(currentStatus == status.Vacant, "Currently occupied.");
        _;
    }

    modifier price(uint256 _amount) {
        // If the value(ether) is > 2, book the hotel if not send the message.
        require(msg.value >= _amount, "Hey Not enogh ether provided.");
        // Specifying is the value is 'true' return to the function execution.
        _;
    }

    // Specify that the function will execute the modifier first.
    function book() public payable onlyIfVacant price(2 ether) {
        /*
     If the value/expression inside the require is true it is going to execute further 
     statement if false stop/break it there & show th message(second argument.
    */

        currentStatus = status.Occupied;

        // replacin this.
        // owner.transfer(msg.value);

        // 'sent' hold the value of transaction status, 'data' holds value of message that i returned. 
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");

        require(sent);
        // triggering an event.
        // Msg.value is sent using the value input in deploy tab
        emit occupies(msg.sender, msg.value);
    }
}
