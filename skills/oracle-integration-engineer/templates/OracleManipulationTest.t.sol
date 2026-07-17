// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {NormalizedOracleAdapter} from "../src/NormalizedOracleAdapter.sol";
import {MockPriceSource} from "../src/MockPriceSource.sol";

contract OracleManipulationTemplateTest is Test {
    MockPriceSource internal source;
    NormalizedOracleAdapter internal adapter;

    function setUp() external {
        source = new MockPriceSource();
        adapter = new NormalizedOracleAdapter(source, 1 hours);
    }

    function testNormalizesEightDecimals() external {
        source.setPrice(2_000e8, 8, block.timestamp);
        assertEq(adapter.read(), 2_000e18);
    }

    function testRejectsStalePrice() external {
        vm.warp(2 hours);
        source.setPrice(2_000e8, 8, block.timestamp - 1 hours - 1);
        vm.expectRevert(NormalizedOracleAdapter.StalePrice.selector);
        adapter.read();
    }

    function testRejectsNegativePrice() external {
        source.setPrice(-1, 8, block.timestamp);
        vm.expectRevert(NormalizedOracleAdapter.InvalidPrice.selector);
        adapter.read();
    }
}
