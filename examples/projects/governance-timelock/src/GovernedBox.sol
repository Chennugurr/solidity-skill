// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract GovernedBox is Ownable {
    uint256 public value;

    constructor(address timelock) Ownable(timelock) {}

    function setValue(uint256 value_) external onlyOwner {
        value = value_;
    }
}
