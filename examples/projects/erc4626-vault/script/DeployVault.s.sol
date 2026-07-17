// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {Script} from "forge-std/Script.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ExampleVault} from "../src/ExampleVault.sol";

contract DeployVault is Script {
    function run() external returns (ExampleVault vault) {
        address asset = vm.envAddress("VAULT_ASSET");
        vm.startBroadcast();
        vault = new ExampleVault(IERC20(asset));
        vm.stopBroadcast();
    }
}
