// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

/// @notice Small target used by the suite's SMTChecker validation.
contract SmtCheckerExample {
    uint256 public total;

    function add(uint128 amount) external {
        uint256 beforeTotal = total;
        total += amount;
        assert(total >= beforeTotal);
    }
}
