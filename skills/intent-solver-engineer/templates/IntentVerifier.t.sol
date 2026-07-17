// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {IntentVerifier} from "../src/IntentVerifier.sol";

contract IntentVerifierTest is Test {
    uint256 internal signerKey = 0xA11CE;
    address internal signer;
    IntentVerifier internal verifier;

    function setUp() external {
        signer = vm.addr(signerKey);
        verifier = new IntentVerifier(address(this));
    }

    function testConsumesBoundedPartialFill() external {
        IntentVerifier.Intent memory intent = _intent();
        bytes32 digest = verifier.hashIntent(intent);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, digest);

        verifier.consume(intent, abi.encodePacked(r, s, v), 40e18);
        verifier.consume(intent, abi.encodePacked(r, s, v), 60e18);
        assertEq(verifier.filledInput(signer, 7), 100e18);
    }

    function testRejectsOverfill() external {
        IntentVerifier.Intent memory intent = _intent();
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(signerKey, verifier.hashIntent(intent));
        vm.expectRevert(IntentVerifier.InvalidFill.selector);
        verifier.consume(intent, abi.encodePacked(r, s, v), 101e18);
    }

    function _intent() internal view returns (IntentVerifier.Intent memory) {
        return IntentVerifier.Intent({
            signer: signer,
            tokenIn: address(1),
            tokenOut: address(2),
            maxInput: 100e18,
            minOutput: 99e18,
            recipient: signer,
            nonce: 7,
            deadline: block.timestamp + 1 hours
        });
    }
}
