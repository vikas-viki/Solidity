// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Arrays {
    // Array is powerful linear datastructure, that can hold huge amount of data with a same type and single name.

/* 
In solidity int, uint & bool directly store the data but they dont
store references.

Whereas arrays atore the references to the actual value but not the value.
*/


    // Uint array
    uint256[] public a = [1, 2, 3, 4, 5];

    // String array
    string[] public b = ["v", "ikas"];

    // Integer array.
    int256[] public c = [-1, -2, 3, 5, 4];

    // Address array
    address[] public e = [
        0x8E4275cfE5Fa615db56bDEcFcdDD1a6268F3e4E7,
        0x8E4275cfE5Fa615db56bDEcFcdDD1a6268F3e4E7,
        0x8E4275cfE5Fa615db56bDEcFcdDD1a6268F3e4E7
    ];

    function addValue(uint256 aval) public returns(uint){
        a.push(aval);
        return a.length;
    }
}
