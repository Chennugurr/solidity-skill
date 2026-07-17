methods {
    function total() external returns (uint256) envfree;
}

invariant totalIsBounded()
    total() <= max_uint256;
