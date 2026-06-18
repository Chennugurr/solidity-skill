// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

/// @title ERC20PermitToken
/// @notice Fixed-supply ERC20 with EIP-2612 permit support and no owner.
contract ERC20PermitToken is ERC20, ERC20Permit {
    error ZeroAddress();

    constructor(
        string memory name_,
        string memory symbol_,
        address initialRecipient,
        uint256 initialSupply
    ) ERC20(name_, symbol_) ERC20Permit(name_) {
        if (initialRecipient == address(0)) revert ZeroAddress();
        _mint(initialRecipient, initialSupply);
    }
}
