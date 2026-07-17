// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC4626} from "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";

/// @notice Educational no-strategy vault using ERC4626 virtual shares and assets.
contract ExampleVault is ERC20, ERC4626 {
    constructor(IERC20 asset_) ERC20("Example Vault Share", "evASSET") ERC4626(asset_) {}

    function decimals() public view override(ERC20, ERC4626) returns (uint8) {
        return super.decimals();
    }

    function _decimalsOffset() internal pure override returns (uint8) {
        return 3;
    }
}
