// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {Script} from "forge-std/Script.sol";
import {TimelockController} from "@openzeppelin/contracts/governance/TimelockController.sol";
import {GovernanceToken} from "../src/GovernanceToken.sol";
import {ExampleGovernor} from "../src/ExampleGovernor.sol";
import {GovernedBox} from "../src/GovernedBox.sol";

contract DeployGovernance is Script {
    function run()
        external
        returns (GovernanceToken token, TimelockController timelock, ExampleGovernor governor, GovernedBox box)
    {
        uint256 key = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(key);
        address recipient = vm.envAddress("GOVERNANCE_TOKEN_RECIPIENT");
        uint256 supply = vm.envUint("GOVERNANCE_TOKEN_SUPPLY");
        uint256 delay = vm.envUint("TIMELOCK_DELAY");
        address[] memory empty = new address[](0);

        vm.startBroadcast(key);
        token = new GovernanceToken(recipient, supply);
        timelock = new TimelockController(delay, empty, empty, deployer);
        governor = new ExampleGovernor(token, timelock);
        box = new GovernedBox(address(timelock));
        timelock.grantRole(timelock.PROPOSER_ROLE(), address(governor));
        timelock.grantRole(timelock.CANCELLER_ROLE(), address(governor));
        timelock.grantRole(timelock.EXECUTOR_ROLE(), address(0));
        timelock.revokeRole(timelock.DEFAULT_ADMIN_ROLE(), deployer);
        vm.stopBroadcast();
    }
}
