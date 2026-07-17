// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

library HealthFactorMath {
    uint256 internal constant WAD = 1e18;

    function healthFactor(uint256 collateralValue, uint256 debtValue, uint256 liquidationThresholdWad)
        internal
        pure
        returns (uint256)
    {
        if (debtValue == 0) return type(uint256).max;
        return Math.mulDiv(collateralValue, liquidationThresholdWad, debtValue);
    }

    function isLiquidatable(uint256 collateralValue, uint256 debtValue, uint256 liquidationThresholdWad)
        internal
        pure
        returns (bool)
    {
        return healthFactor(collateralValue, debtValue, liquidationThresholdWad) < WAD;
    }
}
