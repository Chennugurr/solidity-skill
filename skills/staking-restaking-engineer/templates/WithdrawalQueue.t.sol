// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {WithdrawalQueue} from "../src/WithdrawalQueue.sol";

contract WithdrawalQueueTest is Test {
    address internal operator = address(0x1111);
    address internal staker = address(0x2222);
    WithdrawalQueue internal queue;

    function setUp() external {
        queue = new WithdrawalQueue(operator, 7 days);
    }

    function testConsumesAfterDelayOnce() external {
        vm.prank(staker);
        uint256 requestId = queue.request(10e18);
        vm.warp(block.timestamp + 7 days);
        vm.prank(operator);
        assertEq(queue.consume(staker, requestId), 10e18);

        vm.prank(operator);
        vm.expectRevert(WithdrawalQueue.AlreadyClaimed.selector);
        queue.consume(staker, requestId);
    }
}
