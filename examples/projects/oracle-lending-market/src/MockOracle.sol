// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {IPriceOracle} from "./IPriceOracle.sol";

contract MockOracle is IPriceOracle {
    uint256 public price;

    function setPrice(uint256 price_) external {
        price = price_;
    }

    function priceWad() external view returns (uint256) {
        return price;
    }
}
