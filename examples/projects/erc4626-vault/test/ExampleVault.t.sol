// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {Test} from "forge-std/Test.sol";
import {ExampleVault} from "../src/ExampleVault.sol";
import {VaultAsset} from "../src/VaultAsset.sol";

contract ExampleVaultTest is Test {
    address internal user = address(0xBEEF);
    VaultAsset internal asset;
    ExampleVault internal vault;

    function setUp() external {
        asset = new VaultAsset();
        vault = new ExampleVault(asset);
        asset.mint(user, 1_000_000e18);
        vm.prank(user);
        asset.approve(address(vault), type(uint256).max);
    }

    function testDepositAndRedeem() external {
        vm.startPrank(user);
        uint256 shares = vault.deposit(100e18, user);
        assertGt(shares, 0);
        assertEq(vault.totalAssets(), 100e18);
        assertEq(vault.redeem(shares, user, user), 100e18);
        vm.stopPrank();
    }

    function testFuzzDepositProducesShares(uint96 rawAmount) external {
        uint256 amount = bound(uint256(rawAmount), 1, 1_000_000e18);
        vm.prank(user);
        uint256 shares = vault.deposit(amount, user);
        assertGt(shares, 0);
        assertLe(vault.convertToAssets(shares), amount);
    }

    function testDonationAttackCostsTheAttacker() external {
        asset.mint(address(this), 1_001e18);
        asset.approve(address(vault), type(uint256).max);
        uint256 attackerShares = vault.deposit(1, address(this));
        asset.transfer(address(vault), 1_000e18);

        vm.prank(user);
        uint256 victimShares = vault.deposit(1e18, user);
        uint256 recovered = vault.redeem(attackerShares, address(this), address(this));

        assertGt(victimShares, 0);
        assertLt(recovered, 1_000e18 + 1);
    }
}
