// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {AccessManaged} from "@openzeppelin/contracts/access/manager/AccessManaged.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title AccessManagedERC20
/// @notice ERC20 with minting restricted by an external OpenZeppelin AccessManager.
contract AccessManagedERC20 is ERC20, AccessManaged {
    error ZeroAddress();

    constructor(
        string memory name_,
        string memory symbol_,
        address initialAuthority,
        address initialRecipient,
        uint256 initialSupply
    ) ERC20(name_, symbol_) AccessManaged(initialAuthority) {
        if (initialAuthority == address(0) || initialRecipient == address(0)) revert ZeroAddress();
        _mint(initialRecipient, initialSupply);
    }

    /// @notice Mints tokens when the configured AccessManager authorizes the caller.
    function mint(address to, uint256 amount) external restricted {
        if (to == address(0)) revert ZeroAddress();
        _mint(to, amount);
    }
}
