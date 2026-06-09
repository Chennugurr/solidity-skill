// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {ERC1155Supply} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title BasicERC1155
/// @notice Minimal ERC1155 with owner-controlled minting, batch minting, and supply tracking.
contract BasicERC1155 is ERC1155Supply, Ownable {
    error ZeroAddress();
    error LengthMismatch();

    event ContractURIUpdated(string newURI);

    constructor(string memory uri_, address initialOwner) ERC1155(uri_) Ownable(initialOwner) {
        if (initialOwner == address(0)) revert ZeroAddress();
    }

    /// @notice Mints `amount` of token `id` to `to`.
    function mint(address to, uint256 id, uint256 amount, bytes calldata data) external onlyOwner {
        if (to == address(0)) revert ZeroAddress();
        _mint(to, id, amount, data);
    }

    /// @notice Batch mints multiple token IDs to `to`.
    function mintBatch(
        address to,
        uint256[] calldata ids,
        uint256[] calldata amounts,
        bytes calldata data
    ) external onlyOwner {
        if (to == address(0)) revert ZeroAddress();
        if (ids.length != amounts.length) revert LengthMismatch();
        _mintBatch(to, ids, amounts, data);
    }

    /// @notice Updates the shared ERC1155 metadata URI.
    function setURI(string calldata newURI) external onlyOwner {
        _setURI(newURI);
        emit ContractURIUpdated(newURI);
    }
}
