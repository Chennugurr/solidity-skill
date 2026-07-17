// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {Test} from "forge-std/Test.sol";

contract HalmosExampleTest is Test {
    function check_AdditionIsCommutative(uint128 a, uint128 b) public pure {
        assert(uint256(a) + uint256(b) == uint256(b) + uint256(a));
    }

    function testConcreteControl() external pure {
        assert(uint256(2) + uint256(3) == 5);
    }
}
