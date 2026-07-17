// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {Test} from "forge-std/Test.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {UpgradeableStakingV1} from "../src/UpgradeableStakingV1.sol";
import {UpgradeableStakingV2} from "../src/UpgradeableStakingV2.sol";

contract UpgradeableStakingTest is Test {
    address internal user = address(0xBEEF);
    UpgradeableStakingV1 internal staking;

    function setUp() external {
        UpgradeableStakingV1 implementation = new UpgradeableStakingV1();
        ERC1967Proxy proxy = new ERC1967Proxy(
            address(implementation), abi.encodeCall(UpgradeableStakingV1.initialize, (address(this)))
        );
        staking = UpgradeableStakingV1(payable(address(proxy)));
        vm.deal(user, 10 ether);
    }

    function testImplementationIsLocked() external {
        UpgradeableStakingV1 implementation = new UpgradeableStakingV1();
        vm.expectRevert();
        implementation.initialize(address(this));
    }

    function testUpgradePreservesStateAndAddsDelay() external {
        vm.prank(user);
        staking.stake{value: 2 ether}();

        UpgradeableStakingV2 next = new UpgradeableStakingV2();
        staking.upgradeToAndCall(address(next), abi.encodeCall(UpgradeableStakingV2.initializeV2, (uint64(7 days))));
        UpgradeableStakingV2 upgraded = UpgradeableStakingV2(payable(address(staking)));

        assertEq(upgraded.staked(user), 2 ether);
        assertEq(upgraded.totalStaked(), 2 ether);
        assertEq(upgraded.withdrawalDelay(), 7 days);
        assertEq(upgraded.version(), 2);

        vm.prank(user);
        upgraded.requestWithdrawal();
        vm.warp(block.timestamp + 7 days);
        vm.prank(user);
        upgraded.withdraw(1 ether);
        assertEq(upgraded.staked(user), 1 ether);
    }

    function testNonOwnerCannotUpgrade() external {
        UpgradeableStakingV2 next = new UpgradeableStakingV2();
        vm.prank(user);
        vm.expectRevert();
        staking.upgradeToAndCall(address(next), "");
    }

    function testFuzzUpgradePreservesStake(uint96 rawAmount) external {
        uint256 amount = bound(uint256(rawAmount), 1, 10 ether);
        vm.prank(user);
        staking.stake{value: amount}();

        UpgradeableStakingV2 next = new UpgradeableStakingV2();
        staking.upgradeToAndCall(address(next), abi.encodeCall(UpgradeableStakingV2.initializeV2, (uint64(1 days))));
        UpgradeableStakingV2 upgraded = UpgradeableStakingV2(payable(address(staking)));
        assertEq(upgraded.staked(user), amount);
        assertEq(upgraded.totalStaked(), amount);
    }

    function invariant_TotalStakeMatchesProxyBalance() external view {
        assertEq(staking.totalStaked(), address(staking).balance);
    }
}
