// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {IEntryPoint} from "@account-abstraction/contracts/interfaces/IEntryPoint.sol";
import {ExampleAccount} from "./ExampleAccount.sol";

contract ExampleAccountFactory {
    IEntryPoint public immutable entryPoint;

    constructor(IEntryPoint entryPoint_) {
        entryPoint = entryPoint_;
    }

    function createAccount(address owner, uint256 salt) external returns (ExampleAccount account) {
        address predicted = getAddress(owner, salt);
        if (predicted.code.length != 0) return ExampleAccount(payable(predicted));
        account = new ExampleAccount{salt: _salt(owner, salt)}(entryPoint, owner);
    }

    function getAddress(address owner, uint256 salt) public view returns (address) {
        bytes32 bytecodeHash = keccak256(
            abi.encodePacked(type(ExampleAccount).creationCode, abi.encode(entryPoint, owner))
        );
        return address(
            uint160(
                uint256(
                    keccak256(abi.encodePacked(bytes1(0xff), address(this), _salt(owner, salt), bytecodeHash))
                )
            )
        );
    }

    function _salt(address owner, uint256 salt) internal pure returns (bytes32) {
        return keccak256(abi.encode(owner, salt));
    }
}
