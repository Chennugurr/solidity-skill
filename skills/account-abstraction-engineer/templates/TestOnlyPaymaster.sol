// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Deliberately incomplete sponsorship fixture. It does not implement IPaymaster.
contract TestOnlyPaymaster {
    error NotOwner();
    error NotSponsored();
    error ZeroAddress();

    address public immutable owner;
    mapping(address account => bool sponsored) public isSponsored;

    constructor(address owner_) {
        if (owner_ == address(0)) revert ZeroAddress();
        owner = owner_;
    }

    function setSponsored(address account, bool allowed) external {
        if (msg.sender != owner) revert NotOwner();
        isSponsored[account] = allowed;
    }

    function validateForTest(address account) external view returns (bytes memory context) {
        if (!isSponsored[account]) revert NotSponsored();
        return abi.encode(account);
    }
}
