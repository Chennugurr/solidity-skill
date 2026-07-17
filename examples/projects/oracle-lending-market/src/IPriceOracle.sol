// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

interface IPriceOracle {
    function priceWad() external view returns (uint256);
}
