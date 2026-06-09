// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {ERC4626} from "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title BasicERC4626Vault
/// @notice Basic tokenized vault with no strategy and no fees.
contract BasicERC4626Vault is ERC20, ERC4626, Ownable {
    using SafeERC20 for IERC20;

    error ZeroAddress();
    error AssetRecoveryDisabled();

    constructor(IERC20 asset_, string memory name_, string memory symbol_, address initialOwner)
        ERC20(name_, symbol_)
        ERC4626(asset_)
        Ownable(initialOwner)
    {
        if (address(asset_) == address(0) || initialOwner == address(0)) revert ZeroAddress();
    }

    /// @notice Recovers tokens accidentally sent to the vault, except the vault asset.
    function recoverNonAssetToken(IERC20 token, address recipient, uint256 amount) external onlyOwner {
        if (address(token) == address(asset())) revert AssetRecoveryDisabled();
        if (address(token) == address(0) || recipient == address(0)) revert ZeroAddress();
        token.safeTransfer(recipient, amount);
    }

    function decimals() public view override(ERC20, ERC4626) returns (uint8) {
        return super.decimals();
    }
}
