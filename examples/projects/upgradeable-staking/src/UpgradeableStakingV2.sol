// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {UpgradeableStakingV1} from "./UpgradeableStakingV1.sol";

/// @custom:oz-upgrades-from UpgradeableStakingV1
/// @custom:oz-upgrades-unsafe-allow missing-initializer
contract UpgradeableStakingV2 is UpgradeableStakingV1 {
    error WithdrawalNotReady();

    uint64 public withdrawalDelay;
    mapping(address account => uint64 readyAt) public withdrawalReadyAt;

    function initializeV2(uint64 delay_) external reinitializer(2) onlyOwner {
        withdrawalDelay = delay_;
    }

    function requestWithdrawal() external {
        withdrawalReadyAt[msg.sender] = uint64(block.timestamp) + withdrawalDelay;
    }

    function withdraw(uint256 amount) public override {
        uint64 readyAt = withdrawalReadyAt[msg.sender];
        if (readyAt == 0 || block.timestamp < readyAt) revert WithdrawalNotReady();
        withdrawalReadyAt[msg.sender] = 0;
        super.withdraw(amount);
    }

    function version() external pure returns (uint256) {
        return 2;
    }
}
