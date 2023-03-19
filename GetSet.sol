// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract GetSet{
    string public name;
    uint256 public age;
    address public user;
    int256 public favoriteNum;

    function setName(string memory _name) public returns(string memory) {
        name = _name;
        return name;
    }

    function setAge(uint256 _age) public returns(uint256){
        age = _age;
        return age;
    }

    function setUserAddress(address _user) public returns(address){
        user = _user;
        return user;
    }

    function setFavNum(int256 _num) public returns(int256){
        favoriteNum = _num;
        return favoriteNum;
    }
}