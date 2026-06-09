// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {OwnableERC20} from "../src/OwnableERC20.sol";

contract OwnableERC20Test is Test {
    OwnableERC20 internal token;

    address internal owner = makeAddr("owner");
    address internal alice = makeAddr("alice");
    address internal attacker = makeAddr("attacker");

    function setUp() public {
        token = new OwnableERC20(
            "Example Token",
            "EXAMPLE",
            owner,
            alice,
            1_000_000 ether,
            2_000_000 ether
        );
    }

    function testInitialState() public view {
        assertEq(token.name(), "Example Token");
        assertEq(token.symbol(), "EXAMPLE");
        assertEq(token.owner(), owner);
        assertEq(token.balanceOf(alice), 1_000_000 ether);
        assertEq(token.totalSupply(), 1_000_000 ether);
        assertEq(token.maxSupply(), 2_000_000 ether);
    }

    function testOwnerCanMint() public {
        vm.prank(owner);
        token.mint(alice, 100 ether);

        assertEq(token.balanceOf(alice), 1_000_100 ether);
        assertEq(token.totalSupply(), 1_000_100 ether);
    }

    function testNonOwnerCannotMint() public {
        vm.prank(attacker);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, attacker));
        token.mint(attacker, 100 ether);
    }

    function testCannotMintPastCap() public {
        vm.prank(owner);
        vm.expectRevert(OwnableERC20.CapExceeded.selector);
        token.mint(alice, 1_000_001 ether);
    }

    function testHolderCanBurn() public {
        vm.prank(alice);
        token.burn(100 ether);

        assertEq(token.balanceOf(alice), 999_900 ether);
        assertEq(token.totalSupply(), 999_900 ether);
    }
}
