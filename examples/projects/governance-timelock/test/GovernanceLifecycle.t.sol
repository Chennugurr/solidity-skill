// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {Test} from "forge-std/Test.sol";
import {TimelockController} from "@openzeppelin/contracts/governance/TimelockController.sol";
import {GovernanceToken} from "../src/GovernanceToken.sol";
import {ExampleGovernor} from "../src/ExampleGovernor.sol";
import {GovernedBox} from "../src/GovernedBox.sol";

contract GovernanceLifecycleTest is Test {
    address internal voter = address(0xBEEF);
    GovernanceToken internal token;
    TimelockController internal timelock;
    ExampleGovernor internal governor;
    GovernedBox internal box;

    function setUp() external {
        token = new GovernanceToken(voter, 1_000_000e18);
        address[] memory empty = new address[](0);
        timelock = new TimelockController(2 days, empty, empty, address(this));
        governor = new ExampleGovernor(token, timelock);
        box = new GovernedBox(address(timelock));

        timelock.grantRole(timelock.PROPOSER_ROLE(), address(governor));
        timelock.grantRole(timelock.CANCELLER_ROLE(), address(governor));
        timelock.grantRole(timelock.EXECUTOR_ROLE(), address(0));

        vm.prank(voter);
        token.delegate(voter);
        vm.roll(block.number + 1);
    }

    function testProposalLifecycle() external {
        address[] memory targets = new address[](1);
        targets[0] = address(box);
        uint256[] memory values = new uint256[](1);
        bytes[] memory calldatas = new bytes[](1);
        calldatas[0] = abi.encodeCall(GovernedBox.setValue, (42));
        string memory description = "Set governed value to 42";

        vm.prank(voter);
        uint256 proposalId = governor.propose(targets, values, calldatas, description);
        vm.roll(block.number + governor.votingDelay() + 1);
        vm.prank(voter);
        governor.castVote(proposalId, 1);
        vm.roll(block.number + governor.votingPeriod() + 1);

        bytes32 descriptionHash = keccak256(bytes(description));
        governor.queue(targets, values, calldatas, descriptionHash);
        vm.warp(block.timestamp + timelock.getMinDelay() + 1);
        governor.execute(targets, values, calldatas, descriptionHash);
        assertEq(box.value(), 42);
    }

    function testDirectCallIsRejected() external {
        vm.expectRevert();
        box.setValue(7);
    }

    function testFuzzDirectCallRemainsRejected(uint256 value) external {
        vm.expectRevert();
        box.setValue(value);
    }

    function invariant_GovernanceSupplyIsFixed() external view {
        assertEq(token.totalSupply(), 1_000_000e18);
    }
}
