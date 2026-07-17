// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {Script} from "forge-std/Script.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IPriceOracle} from "../src/IPriceOracle.sol";
import {OracleLendingMarket} from "../src/OracleLendingMarket.sol";

contract DeployMarket is Script {
    function run() external returns (OracleLendingMarket market) {
        IERC20 collateral = IERC20(vm.envAddress("COLLATERAL_TOKEN"));
        IERC20 debt = IERC20(vm.envAddress("DEBT_TOKEN"));
        IPriceOracle oracle = IPriceOracle(vm.envAddress("NORMALIZED_ORACLE"));
        uint256 threshold = vm.envUint("LIQUIDATION_THRESHOLD_WAD");
        uint256 bonus = vm.envUint("LIQUIDATION_BONUS_WAD");
        vm.startBroadcast();
        market = new OracleLendingMarket(collateral, debt, oracle, threshold, bonus);
        vm.stopBroadcast();
    }
}
