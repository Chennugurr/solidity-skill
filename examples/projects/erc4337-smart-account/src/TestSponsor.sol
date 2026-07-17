// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

/// @notice Test-only budget fixture. It is not an ERC-4337 paymaster.
contract TestSponsor {
    error NotOwner();
    error NotEntryPoint();
    error BudgetExceeded();

    address public immutable owner;
    address public immutable entryPoint;
    mapping(address account => uint256 budget) public budget;

    constructor(address owner_, address entryPoint_) {
        owner = owner_;
        entryPoint = entryPoint_;
    }

    function setBudget(address account, uint256 amount) external {
        if (msg.sender != owner) revert NotOwner();
        budget[account] = amount;
    }

    function consume(address account, uint256 amount) external {
        if (msg.sender != entryPoint) revert NotEntryPoint();
        if (amount > budget[account]) revert BudgetExceeded();
        budget[account] -= amount;
    }
}
