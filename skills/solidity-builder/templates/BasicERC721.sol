// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title BasicERC721
/// @notice Simple capped ERC721 with owner-controlled minting and explicit metadata base URI.
contract BasicERC721 is ERC721, Ownable {
    error ZeroAddress();
    error MaxSupplyZero();
    error CapExceeded();

    uint256 public immutable maxSupply;
    uint256 public totalMinted;

    string private baseTokenURI;

    event BaseURIUpdated(string newBaseURI);

    constructor(
        string memory name_,
        string memory symbol_,
        string memory baseTokenURI_,
        address initialOwner,
        uint256 maxSupply_
    ) ERC721(name_, symbol_) Ownable(initialOwner) {
        if (initialOwner == address(0)) revert ZeroAddress();
        if (maxSupply_ == 0) revert MaxSupplyZero();

        baseTokenURI = baseTokenURI_;
        maxSupply = maxSupply_;
    }

    /// @notice Mints the next token ID to `to`.
    function mint(address to) external onlyOwner returns (uint256 tokenId) {
        if (to == address(0)) revert ZeroAddress();
        if (totalMinted >= maxSupply) revert CapExceeded();

        tokenId = totalMinted + 1;
        totalMinted = tokenId;
        _safeMint(to, tokenId);
    }

    /// @notice Updates the base URI used by `tokenURI`.
    function setBaseURI(string calldata newBaseURI) external onlyOwner {
        baseTokenURI = newBaseURI;
        emit BaseURIUpdated(newBaseURI);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }
}
