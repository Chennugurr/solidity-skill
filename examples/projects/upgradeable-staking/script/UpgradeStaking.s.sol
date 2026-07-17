// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {Script} from "forge-std/Script.sol";
import {UpgradeableStakingV1} from "../src/UpgradeableStakingV1.sol";
import {UpgradeableStakingV2} from "../src/UpgradeableStakingV2.sol";

contract UpgradeStaking is Script {
    function run() external returns (UpgradeableStakingV2 upgraded) {
        address proxy = vm.envAddress("STAKING_PROXY");
        uint64 delay = uint64(vm.envUint("WITHDRAWAL_DELAY"));
        vm.startBroadcast();
        UpgradeableStakingV2 implementation = new UpgradeableStakingV2();
        UpgradeableStakingV1(payable(proxy)).upgradeToAndCall(
            address(implementation), abi.encodeCall(UpgradeableStakingV2.initializeV2, (delay))
        );
        vm.stopBroadcast();
        upgraded = UpgradeableStakingV2(payable(proxy));
    }
}
