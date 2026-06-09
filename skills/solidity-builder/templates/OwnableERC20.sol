// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title OwnableERC20
/// @notice ERC20 with transparent owner-controlled minting capped by maxSupply.
contract OwnableERC20 is ERC20, ERC20Burnable, Ownable {
    error ZeroAddress();
    error CapExceeded();

    uint256 public immutable maxSupply;

    event TokensMinted(address indexed recipient, uint256 amount);

    /// @notice Deploys a capped mintable ERC20.
    /// @param name_ Token name.
    /// @param symbol_ Token symbol.
    /// @param initialOwner Owner allowed to mint until the cap is reached.
    /// @param initialRecipient Address receiving the initial supply.
    /// @param initialSupply Initial token supply, including decimals.
    /// @param maxSupply_ Maximum token supply, including decimals.
    constructor(
        string memory name_,
        string memory symbol_,
        address initialOwner,
        address initialRecipient,
        uint256 initialSupply,
        uint256 maxSupply_
    ) ERC20(name_, symbol_) Ownable(initialOwner) {
        if (initialOwner == address(0) || initialRecipient == address(0)) {
            revert ZeroAddress();
        }
        if (initialSupply > maxSupply_) revert CapExceeded();

        maxSupply = maxSupply_;
        _mint(initialRecipient, initialSupply);
    }

    /// @notice Mints tokens to `recipient` while respecting maxSupply.
    /// @param recipient Address receiving minted tokens.
    /// @param amount Amount to mint, including decimals.
    function mint(address recipient, uint256 amount) external onlyOwner {
        if (recipient == address(0)) revert ZeroAddress();
        if (totalSupply() + amount > maxSupply) revert CapExceeded();

        _mint(recipient, amount);
        emit TokensMinted(recipient, amount);
    }
}
