// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {EIP712} from "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import {SignatureChecker} from "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";

/// @notice Verifies and accounts for fills. Asset settlement is intentionally out of scope.
contract IntentVerifier is EIP712 {
    error NotSettlement();
    error IntentExpired();
    error InvalidSignature();
    error InvalidFill();
    error IntentCancelled();
    error ZeroAddress();

    bytes32 public constant INTENT_TYPEHASH = keccak256(
        "Intent(address signer,address tokenIn,address tokenOut,uint256 maxInput,uint256 minOutput,address recipient,uint256 nonce,uint256 deadline)"
    );

    struct Intent {
        address signer;
        address tokenIn;
        address tokenOut;
        uint256 maxInput;
        uint256 minOutput;
        address recipient;
        uint256 nonce;
        uint256 deadline;
    }

    address public immutable settlement;
    mapping(address signer => mapping(uint256 nonce => uint256 filledInput)) public filledInput;
    mapping(address signer => mapping(uint256 nonce => bool cancelled)) public cancelled;

    constructor(address settlement_) EIP712("IntentVerifier", "1") {
        if (settlement_ == address(0)) revert ZeroAddress();
        settlement = settlement_;
    }

    function hashIntent(Intent calldata intent) public view returns (bytes32) {
        return _hashTypedDataV4(
            keccak256(
                abi.encode(
                    INTENT_TYPEHASH,
                    intent.signer,
                    intent.tokenIn,
                    intent.tokenOut,
                    intent.maxInput,
                    intent.minOutput,
                    intent.recipient,
                    intent.nonce,
                    intent.deadline
                )
            )
        );
    }

    function cancel(uint256 nonce) external {
        cancelled[msg.sender][nonce] = true;
    }

    function consume(Intent calldata intent, bytes calldata signature, uint256 inputAmount) external {
        if (msg.sender != settlement) revert NotSettlement();
        if (block.timestamp > intent.deadline) revert IntentExpired();
        if (cancelled[intent.signer][intent.nonce]) revert IntentCancelled();
        if (!SignatureChecker.isValidSignatureNow(intent.signer, hashIntent(intent), signature)) {
            revert InvalidSignature();
        }

        uint256 newFilled = filledInput[intent.signer][intent.nonce] + inputAmount;
        if (inputAmount == 0 || newFilled > intent.maxInput) revert InvalidFill();
        filledInput[intent.signer][intent.nonce] = newFilled;
    }
}
