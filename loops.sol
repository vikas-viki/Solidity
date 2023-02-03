// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract loops {
    function startswith(string[] memory _names, string memory _letter)
        public
        pure
        returns (uint256)
    {
        uint256 trues = 0;
        for (uint256 i = 0; i < _names.length; i++) {
            bytes memory nameBytes = bytes(_names[i]);
            bytes memory letterBytes = bytes(_letter);
            if (nameBytes[0] == letterBytes[0]) {
                trues++;
            }
        }
        return trues;
    }

    function isprimenumber(uint256 _num) public pure returns (bool) {
        uint256 i = 2;
        uint256 flag = 1;

        while (i <= _num / 2) {
            if (_num % i == 0) {
                flag = 0;
            }
            i++;
        }
        if (flag == 0) {
            return false;
        } else {
            return true;
        }
    }
}
