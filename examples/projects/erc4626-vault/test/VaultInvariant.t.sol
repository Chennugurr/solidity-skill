// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {StdInvariant} from "forge-std/StdInvariant.sol";
import {Test} from "forge-std/Test.sol";
import {ExampleVault} from "../src/ExampleVault.sol";
import {VaultAsset} from "../src/VaultAsset.sol";

contract VaultHandler is Test {
    VaultAsset internal immutable asset;
    ExampleVault internal immutable vault;

    constructor(VaultAsset asset_, ExampleVault vault_) {
        asset = asset_;
        vault = vault_;
        asset.approve(address(vault), type(uint256).max);
    }

    function deposit(uint96 rawAmount) external {
        uint256 amount = bound(uint256(rawAmount), 1, 1_000_000e18);
        asset.mint(address(this), amount);
        vault.deposit(amount, address(this));
    }

    function redeem(uint96 rawShares) external {
        uint256 balance = vault.balanceOf(address(this));
        if (balance == 0) return;
        uint256 shares = bound(uint256(rawShares), 1, balance);
        vault.redeem(shares, address(this), address(this));
    }
}

contract VaultInvariantTest is StdInvariant, Test {
    VaultAsset internal asset;
    ExampleVault internal vault;

    function setUp() external {
        asset = new VaultAsset();
        vault = new ExampleVault(asset);
        VaultHandler handler = new VaultHandler(asset, vault);
        targetContract(address(handler));
    }

    function invariantTotalAssetsMatchesBalance() external view {
        assertEq(vault.totalAssets(), asset.balanceOf(address(vault)));
    }
}
