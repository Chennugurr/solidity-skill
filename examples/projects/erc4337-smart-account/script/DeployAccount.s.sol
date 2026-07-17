// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {Script} from "forge-std/Script.sol";
import {IEntryPoint} from "@account-abstraction/contracts/interfaces/IEntryPoint.sol";
import {ExampleAccount} from "../src/ExampleAccount.sol";
import {ExampleAccountFactory} from "../src/ExampleAccountFactory.sol";

contract DeployAccount is Script {
    function run() external returns (ExampleAccountFactory factory, ExampleAccount account) {
        IEntryPoint entryPoint = IEntryPoint(vm.envAddress("ENTRY_POINT"));
        address owner = vm.envAddress("ACCOUNT_OWNER");
        uint256 salt = vm.envUint("ACCOUNT_SALT");
        vm.startBroadcast();
        factory = new ExampleAccountFactory(entryPoint);
        account = factory.createAccount(owner, salt);
        vm.stopBroadcast();
    }
}
