// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import {BaseAccount} from "@account-abstraction/contracts/core/BaseAccount.sol";
import {SIG_VALIDATION_FAILED, SIG_VALIDATION_SUCCESS} from "@account-abstraction/contracts/core/Helpers.sol";
import {IEntryPoint} from "@account-abstraction/contracts/interfaces/IEntryPoint.sol";
import {PackedUserOperation} from "@account-abstraction/contracts/interfaces/PackedUserOperation.sol";

contract ExampleAccount is BaseAccount {
    IEntryPoint internal immutable ACCOUNT_ENTRY_POINT;
    address public immutable owner;

    constructor(IEntryPoint entryPoint_, address owner_) {
        ACCOUNT_ENTRY_POINT = entryPoint_;
        owner = owner_;
    }

    receive() external payable {}

    function entryPoint() public view override returns (IEntryPoint) {
        return ACCOUNT_ENTRY_POINT;
    }

    function _validateSignature(PackedUserOperation calldata userOp, bytes32 userOpHash)
        internal
        view
        override
        returns (uint256)
    {
        (address recovered, ECDSA.RecoverError recoveryError,) = ECDSA.tryRecover(userOpHash, userOp.signature);
        if (recoveryError != ECDSA.RecoverError.NoError || recovered != owner) return SIG_VALIDATION_FAILED;
        return SIG_VALIDATION_SUCCESS;
    }
}
