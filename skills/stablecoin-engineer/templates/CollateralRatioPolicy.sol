// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

library CollateralRatioPolicy {
    uint256 internal constant WAD = 1e18;

    function ratio(uint256 collateralValue, uint256 liabilityValue) internal pure returns (uint256) {
        if (liabilityValue == 0) return type(uint256).max;
        return Math.mulDiv(collateralValue, WAD, liabilityValue);
    }

    function meetsRequirement(uint256 collateralValue, uint256 liabilityValue, uint256 minimumRatioWad)
        internal
        pure
        returns (bool)
    {
        return ratio(collateralValue, liabilityValue) >= minimumRatioWad;
    }
}
