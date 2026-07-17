// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IPriceSourceV2 {
    function latestPrice() external view returns (int256 answer, uint8 decimals, uint256 updatedAt);
}

/// @notice Normalizes a positive, fresh source value to 18 decimals.
contract NormalizedOracleAdapter {
    error InvalidPrice();
    error InvalidTimestamp();
    error StalePrice();
    error UnsupportedDecimals();

    IPriceSourceV2 public immutable source;
    uint256 public immutable maxAge;

    constructor(IPriceSourceV2 source_, uint256 maxAge_) {
        source = source_;
        maxAge = maxAge_;
    }

    function read() external view returns (uint256 priceWad) {
        (int256 answer, uint8 decimals, uint256 updatedAt) = source.latestPrice();
        if (answer <= 0) revert InvalidPrice();
        if (updatedAt > block.timestamp) revert InvalidTimestamp();
        if (block.timestamp - updatedAt > maxAge) revert StalePrice();
        if (decimals > 36) revert UnsupportedDecimals();

        uint256 unsignedAnswer = uint256(answer);
        if (decimals < 18) return unsignedAnswer * (10 ** (18 - decimals));
        if (decimals > 18) return unsignedAnswer / (10 ** (decimals - 18));
        return unsignedAnswer;
    }
}
