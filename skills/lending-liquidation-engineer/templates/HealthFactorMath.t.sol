// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {HealthFactorMath} from "../src/HealthFactorMath.sol";

contract HealthFactorMathTest is Test {
    function testNoDebtHasMaximumHealth() external pure {
        assert(HealthFactorMath.healthFactor(100e18, 0, 80e16) == type(uint256).max);
    }

    function testBoundaryIsNotLiquidatable() external pure {
        assert(!HealthFactorMath.isLiquidatable(125e18, 100e18, 80e16));
    }

    function testBelowBoundaryIsLiquidatable() external pure {
        assert(HealthFactorMath.isLiquidatable(124e18, 100e18, 80e16));
    }
}
