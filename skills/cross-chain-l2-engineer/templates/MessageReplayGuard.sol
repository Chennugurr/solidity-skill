// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @notice Focused message authentication and replay component, not a bridge.
contract MessageReplayGuard {
    error NotMessenger();
    error WrongSource();
    error MessageAlreadyConsumed();
    error InvalidConfiguration();

    address public immutable messenger;
    uint256 public immutable remoteChainId;
    address public immutable remoteSender;
    mapping(bytes32 messageId => bool consumed) public consumed;

    event MessageConsumed(bytes32 indexed messageId, uint256 indexed nonce, bytes32 payloadHash);

    constructor(address messenger_, uint256 remoteChainId_, address remoteSender_) {
        if (messenger_ == address(0) || remoteChainId_ == 0 || remoteSender_ == address(0)) {
            revert InvalidConfiguration();
        }
        messenger = messenger_;
        remoteChainId = remoteChainId_;
        remoteSender = remoteSender_;
    }

    function consume(uint256 sourceChainId, address sourceSender, uint256 nonce, bytes calldata payload)
        external
        returns (bytes32 messageId)
    {
        if (msg.sender != messenger) revert NotMessenger();
        if (sourceChainId != remoteChainId || sourceSender != remoteSender) revert WrongSource();

        bytes32 payloadHash = keccak256(payload);
        messageId = keccak256(
            abi.encode(sourceChainId, block.chainid, sourceSender, address(this), nonce, payloadHash)
        );
        if (consumed[messageId]) revert MessageAlreadyConsumed();
        consumed[messageId] = true;
        emit MessageConsumed(messageId, nonce, payloadHash);
    }
}
