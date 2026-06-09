// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

contract ForkTestTemplate is Test {
    uint256 internal mainnetFork;

    function setUp() public {
        // Replace this with vm.createSelectFork(vm.envString("MAINNET_RPC_URL"), blockNumber)
        // when the test needs live protocol state.
        mainnetFork = block.chainid;
    }

    function testForkTemplateIsConfigured() public view {
        assertGt(mainnetFork, 0);
    }
}

