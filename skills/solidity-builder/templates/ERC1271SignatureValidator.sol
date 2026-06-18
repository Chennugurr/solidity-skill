// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC1271} from "@openzeppelin/contracts/interfaces/IERC1271.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {SignatureChecker} from "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";

/// @title ERC1271SignatureValidator
/// @notice Minimal ERC1271 contract-wallet signature validator with owner-managed signer.
contract ERC1271SignatureValidator is IERC1271, Ownable {
    error ZeroAddress();

    bytes4 internal constant MAGIC_VALUE = IERC1271.isValidSignature.selector;
    bytes4 internal constant INVALID_VALUE = 0xffffffff;

    address public signer;

    event SignerUpdated(address indexed signer);

    constructor(address initialOwner, address initialSigner) Ownable(initialOwner) {
        if (initialOwner == address(0) || initialSigner == address(0)) revert ZeroAddress();
        signer = initialSigner;
        emit SignerUpdated(initialSigner);
    }

    function setSigner(address newSigner) external onlyOwner {
        if (newSigner == address(0)) revert ZeroAddress();
        signer = newSigner;
        emit SignerUpdated(newSigner);
    }

    function isValidSignature(bytes32 hash, bytes calldata signature) external view returns (bytes4) {
        return SignatureChecker.isValidSignatureNow(signer, hash, signature) ? MAGIC_VALUE : INVALID_VALUE;
    }
}
