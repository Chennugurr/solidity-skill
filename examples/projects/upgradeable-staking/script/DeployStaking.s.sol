// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {Script} from "forge-std/Script.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {UpgradeableStakingV1} from "../src/UpgradeableStakingV1.sol";

contract DeployStaking is Script {
    function run() external returns (UpgradeableStakingV1 staking) {
        address owner = vm.envAddress("STAKING_OWNER");
        vm.startBroadcast();
        UpgradeableStakingV1 implementation = new UpgradeableStakingV1();
        ERC1967Proxy proxy = new ERC1967Proxy(
            address(implementation), abi.encodeCall(UpgradeableStakingV1.initialize, (owner))
        );
        vm.stopBroadcast();
        staking = UpgradeableStakingV1(payable(address(proxy)));
    }
}
