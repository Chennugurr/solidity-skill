// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @notice Demonstrates explicit allowlist and freeze controls. Legal review remains required.
contract RestrictedERC20 is ERC20, Ownable {
    error TransferRestricted(address account);

    mapping(address account => bool allowed) public isAllowed;
    mapping(address account => bool frozen) public isFrozen;

    event EligibilitySet(address indexed account, bool allowed);
    event FreezeSet(address indexed account, bool frozen);

    constructor(address controller, address initialHolder, uint256 initialSupply)
        ERC20("Restricted Asset", "RWA")
        Ownable(controller)
    {
        isAllowed[controller] = true;
        isAllowed[initialHolder] = true;
        _mint(initialHolder, initialSupply);
    }

    function setAllowed(address account, bool allowed) external onlyOwner {
        isAllowed[account] = allowed;
        emit EligibilitySet(account, allowed);
    }

    function setFrozen(address account, bool frozen) external onlyOwner {
        isFrozen[account] = frozen;
        emit FreezeSet(account, frozen);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function _update(address from, address to, uint256 value) internal override {
        if (from != address(0) && (!isAllowed[from] || isFrozen[from])) revert TransferRestricted(from);
        if (to != address(0) && (!isAllowed[to] || isFrozen[to])) revert TransferRestricted(to);
        super._update(from, to, value);
    }
}
