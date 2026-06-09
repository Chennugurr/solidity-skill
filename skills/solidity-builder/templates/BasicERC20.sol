// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title BasicERC20
/// @notice Fixed-supply ERC20 token with no owner or privileged functions.
contract BasicERC20 is ERC20 {
    error ZeroAddress();

    /// @notice Deploys a fixed-supply ERC20.
    /// @param name_ Token name.
    /// @param symbol_ Token symbol.
    /// @param initialRecipient Address receiving the full initial supply.
    /// @param initialSupply Full token supply, including decimals.
    constructor(
        string memory name_,
        string memory symbol_,
        address initialRecipient,
        uint256 initialSupply
    ) ERC20(name_, symbol_) {
        if (initialRecipient == address(0)) revert ZeroAddress();
        _mint(initialRecipient, initialSupply);
    }
}
