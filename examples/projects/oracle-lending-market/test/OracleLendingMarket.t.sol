// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {Test} from "forge-std/Test.sol";
import {MockToken} from "../src/MockToken.sol";
import {MockOracle} from "../src/MockOracle.sol";
import {OracleLendingMarket} from "../src/OracleLendingMarket.sol";

contract OracleLendingMarketTest is Test {
    address internal borrower = address(0xB0B);
    address internal liquidator = address(0x1A1);
    MockToken internal collateral;
    MockToken internal debt;
    MockOracle internal oracle;
    OracleLendingMarket internal market;

    function setUp() external {
        collateral = new MockToken("Collateral", "COL");
        debt = new MockToken("Debt USD", "dUSD");
        oracle = new MockOracle();
        oracle.setPrice(2_000e18);
        market = new OracleLendingMarket(collateral, debt, oracle, 80e16, 5e16);

        collateral.mint(borrower, 10e18);
        debt.mint(address(market), 1_000_000e18);
        debt.mint(liquidator, 10_000e18);
        vm.prank(borrower);
        collateral.approve(address(market), type(uint256).max);
        vm.prank(liquidator);
        debt.approve(address(market), type(uint256).max);
    }

    function testBorrowAndRepay() external {
        vm.startPrank(borrower);
        market.depositCollateral(1e18);
        market.borrow(1_000e18);
        assertGt(market.healthFactor(borrower), 1e18);
        debt.approve(address(market), type(uint256).max);
        market.repay(400e18);
        vm.stopPrank();
        assertEq(market.debt(borrower), 600e18);
    }

    function testRejectsUnsafeBorrow() external {
        vm.startPrank(borrower);
        market.depositCollateral(1e18);
        vm.expectRevert(OracleLendingMarket.UnhealthyPosition.selector);
        market.borrow(1_700e18);
        vm.stopPrank();
    }

    function testFuzzSafeBorrowRemainsHealthy(uint96 rawCollateral, uint96 rawBorrow) external {
        uint256 collateralAmount = bound(uint256(rawCollateral), 1e12, 10e18);
        uint256 maxBorrow = collateralAmount * 2_000e18 * 80e16 / 1e18 / 1e18;
        uint256 borrowAmount = bound(uint256(rawBorrow), 1, maxBorrow);
        vm.startPrank(borrower);
        market.depositCollateral(collateralAmount);
        market.borrow(borrowAmount);
        vm.stopPrank();
        assertGe(market.healthFactor(borrower), 1e18);
    }

    function testLiquidatesAfterPriceDrop() external {
        vm.startPrank(borrower);
        market.depositCollateral(1e18);
        market.borrow(1_500e18);
        vm.stopPrank();

        oracle.setPrice(1_500e18);
        vm.prank(liquidator);
        uint256 seized = market.liquidate(borrower, 500e18);
        assertEq(seized, 0.35e18);
        assertEq(market.debt(borrower), 1_000e18);
    }

    function testRejectsZeroOraclePrice() external {
        oracle.setPrice(0);
        vm.prank(borrower);
        market.depositCollateral(1e18);
        vm.prank(borrower);
        vm.expectRevert(OracleLendingMarket.InvalidPrice.selector);
        market.borrow(1e18);
    }

    function invariant_RiskParametersRemainBounded() external view {
        assertLe(market.liquidationThresholdWad(), 1e18);
        assertLe(market.liquidationBonusWad(), 20e16);
    }
}
