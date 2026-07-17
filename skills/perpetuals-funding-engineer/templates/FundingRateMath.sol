// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

library FundingRateMath {
    using SafeCast for uint256;

    int256 internal constant WAD = 1e18;

    function ratePerSecond(int256 skewWad, int256 velocityWad, int256 maximumRateWad)
        internal
        pure
        returns (int256 rate)
    {
        rate = (skewWad * velocityWad) / WAD;
        if (rate > maximumRateWad) return maximumRateWad;
        if (rate < -maximumRateWad) return -maximumRateWad;
    }

    function fundingDelta(int256 positionSize, int256 rateWad, uint256 elapsed)
        internal
        pure
        returns (int256)
    {
        return (positionSize * rateWad * elapsed.toInt256()) / WAD;
    }
}
