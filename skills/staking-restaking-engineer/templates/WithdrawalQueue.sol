// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

/// @notice Queue bookkeeping component. It does not custody or transfer stake assets.
contract WithdrawalQueue {
    using SafeCast for uint256;

    error NotOperator();
    error InvalidShares();
    error NotReady();
    error AlreadyClaimed();
    error ZeroAddress();

    struct Request {
        uint128 shares;
        uint64 availableAt;
        bool claimed;
    }

    address public immutable operator;
    uint64 public immutable delay;
    mapping(address requester => Request[]) internal requests;

    event Requested(address indexed requester, uint256 indexed requestId, uint256 shares, uint256 availableAt);
    event Consumed(address indexed requester, uint256 indexed requestId, uint256 shares);

    constructor(address operator_, uint64 delay_) {
        if (operator_ == address(0)) revert ZeroAddress();
        operator = operator_;
        delay = delay_;
    }

    function request(uint128 shares) external returns (uint256 requestId) {
        if (shares == 0) revert InvalidShares();
        requestId = requests[msg.sender].length;
        uint64 availableAt = (block.timestamp + delay).toUint64();
        requests[msg.sender].push(Request(shares, availableAt, false));
        emit Requested(msg.sender, requestId, shares, availableAt);
    }

    function consume(address requester, uint256 requestId) external returns (uint256 shares) {
        if (msg.sender != operator) revert NotOperator();
        Request storage item = requests[requester][requestId];
        if (item.claimed) revert AlreadyClaimed();
        if (block.timestamp < item.availableAt) revert NotReady();
        item.claimed = true;
        shares = item.shares;
        emit Consumed(requester, requestId, shares);
    }

    function getRequest(address requester, uint256 requestId) external view returns (Request memory) {
        return requests[requester][requestId];
    }
}
