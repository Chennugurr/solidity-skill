// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {FundingRateMath} from "../src/FundingRateMath.sol";

contract FundingRateMathTest is Test {
    function testCapsPositiveAndNegativeRate() external pure {
        assert(FundingRateMath.ratePerSecond(1e18, 2e16, 1e16) == 1e16);
        assert(FundingRateMath.ratePerSecond(-1e18, 2e16, 1e16) == -1e16);
    }

    function testFundingChangesSignWithPosition() external pure {
        int256 longDelta = FundingRateMath.fundingDelta(10e18, 1e14, 10);
        int256 shortDelta = FundingRateMath.fundingDelta(-10e18, 1e14, 10);
        assert(longDelta == -shortDelta);
    }
}
