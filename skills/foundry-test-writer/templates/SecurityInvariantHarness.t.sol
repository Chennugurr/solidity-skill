// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

contract SolvencySubject {
    error InsufficientBalance();

    mapping(address => uint256) public balanceOf;
    uint256 public totalDeposits;
    uint256 public totalWithdrawn;

    function deposit(uint256 amount) external {
        balanceOf[msg.sender] += amount;
        totalDeposits += amount;
    }

    function withdraw(uint256 amount) external {
        if (balanceOf[msg.sender] < amount) revert InsufficientBalance();

        balanceOf[msg.sender] -= amount;
        totalWithdrawn += amount;
    }
}

contract SolvencyHandler is Test {
    SolvencySubject public subject;
    uint256 public ghostOutstanding;

    address[] internal actors;

    constructor(SolvencySubject subject_) {
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

        ghostOutstanding += amount;
    }

    function withdraw(uint256 actorSeed, uint256 amount) external {
        address actor = actors[actorSeed % actors.length];
        uint256 balance = subject.balanceOf(actor);
        amount = bound(amount, 0, balance);

        vm.prank(actor);
        subject.withdraw(amount);

        ghostOutstanding -= amount;
    }
}

contract SecurityInvariantHarness is Test {
    SolvencySubject internal subject;
    SolvencyHandler internal handler;

    function setUp() public {
        subject = new SolvencySubject();
        handler = new SolvencyHandler(subject);
        targetContract(address(handler));
    }

    function invariant_OutstandingMatchesGhostAccounting() public view {
        assertEq(subject.totalDeposits() - subject.totalWithdrawn(), handler.ghostOutstanding());
    }
}
