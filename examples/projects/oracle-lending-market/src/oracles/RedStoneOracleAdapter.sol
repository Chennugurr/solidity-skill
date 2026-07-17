// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {PrimaryProdDataServiceConsumerBase} from "@redstone-finance/evm-connector/contracts/data-services/PrimaryProdDataServiceConsumerBase.sol";
import {IPriceOracle} from "../IPriceOracle.sol";

/// @notice Reads a RedStone primary-production value appended to transaction calldata.
contract RedStoneOracleAdapter is PrimaryProdDataServiceConsumerBase, IPriceOracle {
    error UnsupportedDecimals();

    bytes32 public immutable dataFeedId;
    uint8 public immutable sourceDecimals;

    constructor(bytes32 dataFeedId_, uint8 sourceDecimals_) {
        if (sourceDecimals_ > 36) revert UnsupportedDecimals();
        dataFeedId = dataFeedId_;
        sourceDecimals = sourceDecimals_;
    }

    function priceWad() external view returns (uint256) {
        uint256 value = getOracleNumericValueFromTxMsg(dataFeedId);
        if (sourceDecimals < 18) return value * (10 ** (18 - sourceDecimals));
        if (sourceDecimals > 18) return value / (10 ** (sourceDecimals - 18));
        return value;
    }
}
