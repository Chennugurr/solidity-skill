// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {MessageReplayGuard} from "../src/MessageReplayGuard.sol";

contract MessageReplayGuardTest is Test {
    address internal messenger = address(0x1111);
    address internal remoteSender = address(0x2222);
    MessageReplayGuard internal guard;

    function setUp() external {
        guard = new MessageReplayGuard(messenger, 10, remoteSender);
    }

    function testConsumesOnce() external {
        vm.prank(messenger);
        guard.consume(10, remoteSender, 1, hex"1234");

        vm.prank(messenger);
        vm.expectRevert(MessageReplayGuard.MessageAlreadyConsumed.selector);
        guard.consume(10, remoteSender, 1, hex"1234");
    }

    function testRejectsWrongMessenger() external {
        vm.expectRevert(MessageReplayGuard.NotMessenger.selector);
        guard.consume(10, remoteSender, 1, hex"1234");
    }
}
