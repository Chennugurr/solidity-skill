// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {OwnableERC20} from "../src/OwnableERC20.sol";

contract Deploy is Script {
    function run() external returns (OwnableERC20 token) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address initialOwner = vm.envAddress("OWNER");
        address initialRecipient = vm.envAddress("INITIAL_RECIPIENT");
        uint256 initialSupply = vm.envUint("INITIAL_SUPPLY");
        uint256 maxSupply = vm.envUint("MAX_SUPPLY");

        vm.startBroadcast(deployerPrivateKey);
        token = new OwnableERC20(
            "Example Token",
            "EXAMPLE",
            initialOwner,
            initialRecipient,
            initialSupply,
            maxSupply
        );
        vm.stopBroadcast();
    }
}
