// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Maps {
    //  Similar to store data in key value pairs similar to maps in js.
    mapping(int => uint256) public holdings;

    // Nestesd maps.
    mapping(uint256=>mapping(string=>uint256)) public User;

    // Adding values to map.
    function transact(int _id, uint256 _value) public {
        holdings[_id] = _value;
    }

    // Adding values to nested maps.
    function adduser(uint256 _Id,string memory _name, uint256 _age)public {
        User[_Id][_name]=_age;
    }
}
