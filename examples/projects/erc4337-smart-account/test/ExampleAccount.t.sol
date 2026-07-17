// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {Test} from "forge-std/Test.sol";
import {IEntryPoint} from "@account-abstraction/contracts/interfaces/IEntryPoint.sol";
import {PackedUserOperation} from "@account-abstraction/contracts/interfaces/PackedUserOperation.sol";
import {ExampleAccount} from "../src/ExampleAccount.sol";
import {ExampleAccountFactory} from "../src/ExampleAccountFactory.sol";
import {TestSponsor} from "../src/TestSponsor.sol";

contract MockEntryPoint {
    mapping(address account => uint256 nonce) public nonce;

    function getNonce(address account, uint192) external view returns (uint256) {
        return nonce[account];
    }

    function validate(ExampleAccount account, PackedUserOperation calldata userOp, bytes32 userOpHash)
        external
        returns (uint256 validationData)
    {
        require(userOp.nonce == nonce[address(account)], "nonce");
        validationData = account.validateUserOp(userOp, userOpHash, 0);
        if (validationData == 0) nonce[address(account)]++;
    }

    function execute(ExampleAccount account, address target, uint256 value, bytes calldata data) external {
        account.execute(target, value, data);
    }

    function consumeSponsor(TestSponsor sponsor, address account, uint256 amount) external {
        sponsor.consume(account, amount);
    }

    receive() external payable {}
}

contract CallTarget {
    uint256 public number;

    function setNumber(uint256 number_) external {
        number = number_;
    }
}

contract ExampleAccountTest is Test {
    uint256 internal ownerKey = 0xA11CE;
    address internal owner;
    MockEntryPoint internal mockEntryPoint;
    ExampleAccountFactory internal factory;
    ExampleAccount internal account;

    function setUp() external {
        owner = vm.addr(ownerKey);
        mockEntryPoint = new MockEntryPoint();
        factory = new ExampleAccountFactory(IEntryPoint(address(mockEntryPoint)));
        account = factory.createAccount(owner, 7);
    }

    function testFactoryAddressIsDeterministic() external view {
        assertEq(address(account), factory.getAddress(owner, 7));
    }

    function testFuzzFactoryAddressIsDeterministic(uint96 salt) external {
        ExampleAccount created = factory.createAccount(owner, salt);
        assertEq(address(created), factory.getAddress(owner, salt));
    }

    function testValidatesAndExecutesSignedOperation() external {
        bytes32 userOpHash = keccak256("example-user-operation");
        PackedUserOperation memory userOp = _userOp(userOpHash);
        assertEq(mockEntryPoint.validate(account, userOp, userOpHash), 0);

        CallTarget target = new CallTarget();
        mockEntryPoint.execute(account, address(target), 0, abi.encodeCall(CallTarget.setNumber, (42)));
        assertEq(target.number(), 42);
    }

    function testRejectsReplayNonce() external {
        bytes32 userOpHash = keccak256("nonce-test");
        PackedUserOperation memory userOp = _userOp(userOpHash);
        mockEntryPoint.validate(account, userOp, userOpHash);
        vm.expectRevert(bytes("nonce"));
        mockEntryPoint.validate(account, userOp, userOpHash);
    }

    function testRejectsDirectValidationCaller() external {
        PackedUserOperation memory userOp;
        vm.expectRevert();
        account.validateUserOp(userOp, bytes32(0), 0);
    }

    function testSponsorBudgetIsBounded() external {
        TestSponsor sponsor = new TestSponsor(address(this), address(mockEntryPoint));
        sponsor.setBudget(address(account), 1 ether);
        mockEntryPoint.consumeSponsor(sponsor, address(account), 0.4 ether);
        assertEq(sponsor.budget(address(account)), 0.6 ether);
        vm.expectRevert(TestSponsor.BudgetExceeded.selector);
        mockEntryPoint.consumeSponsor(sponsor, address(account), 0.7 ether);
    }

    function invariant_AccountAuthorityIsPinned() external view {
        assertEq(account.owner(), owner);
        assertEq(address(account.entryPoint()), address(mockEntryPoint));
    }

    function _userOp(bytes32 userOpHash) internal view returns (PackedUserOperation memory userOp) {
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerKey, userOpHash);
        userOp.sender = address(account);
        userOp.nonce = 0;
        userOp.signature = abi.encodePacked(r, s, v);
    }
}
