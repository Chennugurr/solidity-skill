// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {IPyth} from "@pythnetwork/pyth-sdk-solidity/IPyth.sol";
import {PythStructs} from "@pythnetwork/pyth-sdk-solidity/PythStructs.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {IPriceOracle} from "../IPriceOracle.sol";

contract PythOracleAdapter is IPriceOracle {
    error InvalidPrice();
    error UnsupportedExponent();
    error ConfidenceTooWide();

    IPyth public immutable pyth;
    bytes32 public immutable priceId;
    uint256 public immutable maxAge;
    uint256 public immutable maxConfidenceRatioWad;

    constructor(IPyth pyth_, bytes32 priceId_, uint256 maxAge_, uint256 maxConfidenceRatioWad_) {
        pyth = pyth_;
        priceId = priceId_;
        maxAge = maxAge_;
        maxConfidenceRatioWad = maxConfidenceRatioWad_;
    }

    function priceWad() external view returns (uint256) {
        PythStructs.Price memory result = pyth.getPriceNoOlderThan(priceId, maxAge);
        if (result.price <= 0) revert InvalidPrice();
        uint256 value = _toWad(uint256(uint64(result.price)), result.expo);
        uint256 confidence = _toWad(uint256(result.conf), result.expo);
        if (Math.mulDiv(confidence, 1e18, value) > maxConfidenceRatioWad) revert ConfidenceTooWide();
        return value;
    }

    function _toWad(uint256 value, int32 exponent) internal pure returns (uint256) {
        if (exponent < -36 || exponent > 18) revert UnsupportedExponent();
        int256 scale = int256(exponent) + 18;
        if (scale >= 0) return value * (10 ** uint256(scale));
        return value / (10 ** uint256(-scale));
    }
}
