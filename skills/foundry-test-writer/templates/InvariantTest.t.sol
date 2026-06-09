// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

contract AccountingSubject {
    error InsufficientBalance();

    uint256 public total;
    mapping(address => uint256) public balanceOf;

    function deposit(uint256 amount) external {
        balanceOf[msg.sender] += amount;
        total += amount;
    }

    function withdraw(uint256 amount) external {
        if (balanceOf[msg.sender] < amount) revert InsufficientBalance();

        balanceOf[msg.sender] -= amount;
        total -= amount;
    }
}

contract AccountingHandler is Test {
    AccountingSubject public subject;
    uint256 public ghostTotal;

    address[] internal actors;

    constructor(AccountingSubject subject_) {
        subject = subject_;
        actors.push(makeAddr("alice"));
        actors.push(makeAddr("bob"));
        actors.push(makeAddr("carol"));
    }

    function deposit(uint256 actorSeed, uint256 amount) external {
        address actor = actors[actorSeed % actors.length];
        amount = bound(amount, 0, 1e24);

        vm.prank(actor);
        subject.deposit(amount);

        ghostTotal += amount;
    }

    function withdraw(uint256 actorSeed, uint256 amount) external {
        address actor = actors[actorSeed % actors.length];
        uint256 balance = subject.balanceOf(actor);
        amount = bound(amount, 0, balance);

        vm.prank(actor);
        subject.withdraw(amount);

        ghostTotal -= amount;
    }
}

contract InvariantTestTemplate is Test {
    AccountingSubject internal subject;
    AccountingHandler internal handler;

    function setUp() public {
        subject = new AccountingSubject();
        handler = new AccountingHandler(subject);

        targetContract(address(handler));
    }

    function invariant_TotalMatchesGhostAccounting() public view {
        assertEq(subject.total(), handler.ghostTotal());
    }
}

