// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

/// @custom:oz-upgrades
contract UpgradeableStakingV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    error InvalidAmount();
    error InsufficientStake();
    error TransferFailed();

    mapping(address account => uint256 amount) public staked;
    uint256 public totalStaked;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address owner_) external initializer {
        __Ownable_init(owner_);
    }

    function stake() external payable {
        if (msg.value == 0) revert InvalidAmount();
        staked[msg.sender] += msg.value;
        totalStaked += msg.value;
    }

    function withdraw(uint256 amount) public virtual {
        if (amount == 0 || amount > staked[msg.sender]) revert InsufficientStake();
        staked[msg.sender] -= amount;
        totalStaked -= amount;
        (bool success,) = payable(msg.sender).call{value: amount}("");
        if (!success) revert TransferFailed();
    }

    function _authorizeUpgrade(address) internal override onlyOwner {}
}
