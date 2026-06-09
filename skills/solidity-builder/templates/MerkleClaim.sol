// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/// @title MerkleClaim
/// @notice Pull-based ERC20 Merkle claim contract with one claim per address.
contract MerkleClaim is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    error ZeroAddress();
    error InvalidRoot();
    error ClaimExpired();
    error ClaimActive();
    error AlreadyClaimed();
    error InvalidProof();

    IERC20 public immutable token;
    bytes32 public immutable merkleRoot;
    uint64 public immutable deadline;

    mapping(address account => bool) public claimed;

    event Claimed(address indexed account, uint256 amount);
    event ClawedBack(address indexed recipient, uint256 amount);

    constructor(IERC20 token_, bytes32 merkleRoot_, uint64 deadline_, address initialOwner) Ownable(initialOwner) {
        if (address(token_) == address(0) || initialOwner == address(0)) revert ZeroAddress();
        if (merkleRoot_ == bytes32(0)) revert InvalidRoot();

        token = token_;
        merkleRoot = merkleRoot_;
        deadline = deadline_;
    }

    /// @notice Claims `amount` for `account` using a Merkle proof over `(account, amount)`.
    function claim(address account, uint256 amount, bytes32[] calldata proof) external nonReentrant {
        if (block.timestamp > deadline) revert ClaimExpired();
        if (claimed[account]) revert AlreadyClaimed();

        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(account, amount))));
        if (!MerkleProof.verifyCalldata(proof, merkleRoot, leaf)) revert InvalidProof();

        claimed[account] = true;
        token.safeTransfer(account, amount);

        emit Claimed(account, amount);
    }

    /// @notice Recovers unclaimed tokens after the claim deadline.
    function clawback(address recipient, uint256 amount) external onlyOwner {
        if (block.timestamp <= deadline) revert ClaimActive();
        if (recipient == address(0)) revert ZeroAddress();

        token.safeTransfer(recipient, amount);
        emit ClawedBack(recipient, amount);
    }
}
