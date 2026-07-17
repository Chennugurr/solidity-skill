// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {RestrictedERC20} from "../src/RestrictedERC20.sol";

contract RestrictedERC20Test is Test {
    address internal holder = address(0x1111);
    address internal recipient = address(0x2222);
    RestrictedERC20 internal token;

    function setUp() external {
        token = new RestrictedERC20(address(this), holder, 100e18);
    }

    function testRequiresEligibleRecipient() external {
        vm.prank(holder);
        vm.expectRevert(abi.encodeWithSelector(RestrictedERC20.TransferRestricted.selector, recipient));
        token.transfer(recipient, 1e18);

        token.setAllowed(recipient, true);
        vm.prank(holder);
        token.transfer(recipient, 1e18);
        assertEq(token.balanceOf(recipient), 1e18);
    }

    function testFrozenHolderCannotTransfer() external {
        token.setFrozen(holder, true);
        vm.prank(holder);
        vm.expectRevert(abi.encodeWithSelector(RestrictedERC20.TransferRestricted.selector, holder));
        token.transfer(address(this), 1e18);
    }
}
