// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {CollateralRatioPolicy} from "../src/CollateralRatioPolicy.sol";

contract CollateralRatioPolicyTest is Test {
    function testRequiresDeclaredRatio() external pure {
        assert(CollateralRatioPolicy.meetsRequirement(150e18, 100e18, 150e16));
        assert(!CollateralRatioPolicy.meetsRequirement(149e18, 100e18, 150e16));
    }

    function testNoLiabilityHasMaximumRatio() external pure {
        assert(CollateralRatioPolicy.ratio(0, 0) == type(uint256).max);
    }
}
