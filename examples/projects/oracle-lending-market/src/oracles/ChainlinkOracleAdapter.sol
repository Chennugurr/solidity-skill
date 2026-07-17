// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {IPriceOracle} from "../IPriceOracle.sol";

contract ChainlinkOracleAdapter is IPriceOracle {
    error InvalidAnswer();
    error StaleAnswer();
    error UnsupportedDecimals();

    AggregatorV3Interface public immutable feed;
    uint256 public immutable maxAge;

    constructor(AggregatorV3Interface feed_, uint256 maxAge_) {
        feed = feed_;
        maxAge = maxAge_;
    }

    function priceWad() external view returns (uint256) {
        (, int256 answer,, uint256 updatedAt,) = feed.latestRoundData();
        if (answer <= 0) revert InvalidAnswer();
        if (updatedAt > block.timestamp || block.timestamp - updatedAt > maxAge) revert StaleAnswer();
        uint8 decimals = feed.decimals();
        if (decimals > 36) revert UnsupportedDecimals();
        uint256 value = uint256(answer);
        if (decimals < 18) return value * (10 ** (18 - decimals));
        if (decimals > 18) return value / (10 ** (decimals - 18));
        return value;
    }
}
