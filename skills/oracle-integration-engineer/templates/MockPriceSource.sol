// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IPriceSourceV2} from "./NormalizedOracleAdapter.sol";

contract MockPriceSource is IPriceSourceV2 {
    int256 public answer;
    uint8 public sourceDecimals;
    uint256 public updatedAt;

    function setPrice(int256 answer_, uint8 decimals_, uint256 updatedAt_) external {
        answer = answer_;
        sourceDecimals = decimals_;
        updatedAt = updatedAt_;
    }

    function latestPrice() external view returns (int256, uint8, uint256) {
        return (answer, sourceDecimals, updatedAt);
    }
}
