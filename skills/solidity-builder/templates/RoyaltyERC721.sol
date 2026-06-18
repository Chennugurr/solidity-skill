// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC2981} from "@openzeppelin/contracts/token/common/ERC2981.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title RoyaltyERC721
/// @notice Capped ERC721 with ERC2981 royalty metadata.
contract RoyaltyERC721 is ERC721, ERC2981, Ownable {
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
        address royaltyReceiver,
        uint96 royaltyFeeNumerator,
        uint256 maxSupply_
    ) ERC721(name_, symbol_) Ownable(initialOwner) {
        if (initialOwner == address(0) || royaltyReceiver == address(0)) revert ZeroAddress();
        if (maxSupply_ == 0) revert MaxSupplyZero();

        baseTokenURI = baseTokenURI_;
        maxSupply = maxSupply_;
        _setDefaultRoyalty(royaltyReceiver, royaltyFeeNumerator);
    }

    function mint(address to) external onlyOwner returns (uint256 tokenId) {
        if (to == address(0)) revert ZeroAddress();
        if (totalMinted >= maxSupply) revert CapExceeded();

        tokenId = totalMinted + 1;
        totalMinted = tokenId;
        _safeMint(to, tokenId);
    }

    function setBaseURI(string calldata newBaseURI) external onlyOwner {
        baseTokenURI = newBaseURI;
        emit BaseURIUpdated(newBaseURI);
    }

    function setDefaultRoyalty(address receiver, uint96 feeNumerator) external onlyOwner {
        if (receiver == address(0)) revert ZeroAddress();
        _setDefaultRoyalty(receiver, feeNumerator);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC2981) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
