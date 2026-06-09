// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/// @title TokenVesting
/// @notice Single-beneficiary linear vesting wallet for ERC20 tokens.
contract TokenVesting {
    using SafeERC20 for IERC20;

    error ZeroAddress();
    error InvalidSchedule();
    error NothingToRelease();

    IERC20 public immutable token;
    address public immutable beneficiary;
    uint64 public immutable start;
    uint64 public immutable cliff;
    uint64 public immutable duration;

    uint256 public released;

    event TokensReleased(address indexed beneficiary, uint256 amount);

    constructor(
        IERC20 token_,
        address beneficiary_,
        uint64 start_,
        uint64 cliffDuration,
        uint64 duration_
    ) {
        if (address(token_) == address(0) || beneficiary_ == address(0)) revert ZeroAddress();
        if (duration_ == 0 || cliffDuration > duration_) revert InvalidSchedule();

        token = token_;
        beneficiary = beneficiary_;
        start = start_;
        cliff = start_ + cliffDuration;
        duration = duration_;
    }

    /// @notice Returns the releasable vested amount.
    function releasable() public view returns (uint256) {
        return vestedAmount(uint64(block.timestamp)) - released;
    }

    /// @notice Releases vested tokens to the beneficiary.
    function release() external {
        uint256 amount = releasable();
        if (amount == 0) revert NothingToRelease();

        released += amount;
        token.safeTransfer(beneficiary, amount);

        emit TokensReleased(beneficiary, amount);
    }

    /// @notice Returns the total amount vested by `timestamp`.
    function vestedAmount(uint64 timestamp) public view returns (uint256) {
        uint256 totalAllocation = token.balanceOf(address(this)) + released;

        if (timestamp < cliff) {
            return 0;
        }
        if (timestamp >= start + duration) {
            return totalAllocation;
        }

        return (totalAllocation * (timestamp - start)) / duration;
    }
}
