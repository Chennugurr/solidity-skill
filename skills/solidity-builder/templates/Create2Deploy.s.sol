// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {Create2} from "@openzeppelin/contracts/utils/Create2.sol";
import {OwnableERC20} from "../src/OwnableERC20.sol";

contract Create2Deploy is Script {
    function run() external returns (address deployed) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        bytes32 salt = vm.envBytes32("CREATE2_SALT");
        bytes memory bytecode = tokenBytecode();

        vm.startBroadcast(deployerPrivateKey);
        deployed = Create2.deploy(0, salt, bytecode);
        vm.stopBroadcast();
    }

    function computeTokenAddress(bytes32 salt) external view returns (address) {
        return Create2.computeAddress(salt, keccak256(tokenBytecode()));
    }

    function tokenBytecode() internal view returns (bytes memory) {
        address initialOwner = vm.envAddress("OWNER");
        address initialRecipient = vm.envAddress("INITIAL_RECIPIENT");
        uint256 initialSupply = vm.envUint("INITIAL_SUPPLY");
        uint256 maxSupply = vm.envUint("MAX_SUPPLY");

        return abi.encodePacked(
            type(OwnableERC20).creationCode,
            abi.encode(
                "Example Token",
                "EXAMPLE",
                initialOwner,
                initialRecipient,
                initialSupply,
                maxSupply
            )
        );
    }
}
