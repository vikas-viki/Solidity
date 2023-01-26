// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Variables {
    // making variables public, makes it availaibe outside of contract also
    // State variables, accessible throught the program.
    uint public age = 18;

    // Specifying the number of bits.
    uint256 marks = 1234;

    // Type Integer.
    int  a = 10;

    // Type string.
    string hello = "Hello";

    // Type byte(string), stores string with specified bytes.
    bytes32 name = "0x8...";

    // Type address, used to store the addres of node.
    address myaddress = 0x8E4275cfE5Fa615db56bDEcFcdDD1a6268F3e4E7;

    // Creating custom datatypes using structs.
    struct student {
        string name;
        int age;
        bytes32 registerNo;
    }
    student public vikas = student("0x4...", 18, "S0154");

    function setAge(uint x) public {
        age = x;
    }

    function checkDegree()public view returns(bool){
        // Local variables, can be accessed inside of the function only.
        bool graduate = false;
        if(age >= 20){
            graduate = true;
            return graduate;
        }else{
            graduate = false;
            return graduate ;
        }
    }
}