// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC6909} from "@openzeppelin/contracts/token/ERC6909/ERC6909.sol";
import {ERC6909Metadata} from "@openzeppelin/contracts/token/ERC6909/extensions/ERC6909Metadata.sol";
import {ERC6909TokenSupply} from "@openzeppelin/contracts/token/ERC6909/extensions/ERC6909TokenSupply.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title BasicERC6909
/// @notice Draft-friendly multi-token ERC6909 example with owner-controlled metadata and minting.
contract BasicERC6909 is ERC6909Metadata, ERC6909TokenSupply, Ownable {
    error ZeroAddress();

    event TokenConfigured(uint256 indexed id, string name, string symbol, uint8 decimals);

    constructor(address initialOwner) Ownable(initialOwner) {
        if (initialOwner == address(0)) revert ZeroAddress();
    }

    function configureToken(
        uint256 id,
        string calldata name_,
        string calldata symbol_,
        uint8 decimals_
    ) external onlyOwner {
        _setName(id, name_);
        _setSymbol(id, symbol_);
        _setDecimals(id, decimals_);

        emit TokenConfigured(id, name_, symbol_, decimals_);
    }

    function mint(address to, uint256 id, uint256 amount) external onlyOwner {
        if (to == address(0)) revert ZeroAddress();
        _mint(to, id, amount);
    }

    function burn(address from, uint256 id, uint256 amount) external onlyOwner {
        if (from == address(0)) revert ZeroAddress();
        _burn(from, id, amount);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC6909Metadata, ERC6909TokenSupply)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function _update(address from, address to, uint256 id, uint256 amount)
        internal
        override(ERC6909, ERC6909TokenSupply)
    {
        super._update(from, to, id, amount);
    }
}
