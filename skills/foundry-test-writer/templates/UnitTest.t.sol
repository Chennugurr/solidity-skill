// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

contract ExampleSubject {
    error ZeroAmount();

    uint256 public total;
    mapping(address => uint256) public balanceOf;

    event Deposited(address indexed user, uint256 amount);

    function deposit(uint256 amount) external {
        if (amount == 0) revert ZeroAmount();

        balanceOf[msg.sender] += amount;
        total += amount;

        emit Deposited(msg.sender, amount);
    }
}

contract UnitTestTemplate is Test {
    ExampleSubject internal subject;

    address internal alice = makeAddr("alice");

    function setUp() public {
        subject = new ExampleSubject();
    }

    function testInitialState() public view {
        assertEq(subject.total(), 0);
        assertEq(subject.balanceOf(alice), 0);
    }

    function testDeposit() public {
        vm.prank(alice);
        subject.deposit(100);

        assertEq(subject.balanceOf(alice), 100);
        assertEq(subject.total(), 100);
    }

    function testCannotDepositZero() public {
        vm.prank(alice);
        vm.expectRevert(ExampleSubject.ZeroAmount.selector);
        subject.deposit(0);
    }
}

