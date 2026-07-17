// SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {IPriceOracle} from "./IPriceOracle.sol";

/// @notice Educational isolated market with no interest or pooled supplier shares.
contract OracleLendingMarket {
    using SafeERC20 for IERC20;

    error InvalidAmount();
    error InvalidPrice();
    error UnhealthyPosition();
    error HealthyPosition();
    error InsufficientCollateral();

    uint256 public constant WAD = 1e18;
    IERC20 public immutable collateralToken;
    IERC20 public immutable debtToken;
    IPriceOracle public immutable oracle;
    uint256 public immutable liquidationThresholdWad;
    uint256 public immutable liquidationBonusWad;

    mapping(address account => uint256 amount) public collateral;
    mapping(address account => uint256 amount) public debt;

    constructor(
        IERC20 collateralToken_,
        IERC20 debtToken_,
        IPriceOracle oracle_,
        uint256 liquidationThresholdWad_,
        uint256 liquidationBonusWad_
    ) {
        collateralToken = collateralToken_;
        debtToken = debtToken_;
        oracle = oracle_;
        liquidationThresholdWad = liquidationThresholdWad_;
        liquidationBonusWad = liquidationBonusWad_;
    }

    function depositCollateral(uint256 amount) external {
        if (amount == 0) revert InvalidAmount();
        collateral[msg.sender] += amount;
        collateralToken.safeTransferFrom(msg.sender, address(this), amount);
    }

    function withdrawCollateral(uint256 amount) external {
        if (amount == 0 || amount > collateral[msg.sender]) revert InsufficientCollateral();
        collateral[msg.sender] -= amount;
        if (!_healthy(msg.sender)) revert UnhealthyPosition();
        collateralToken.safeTransfer(msg.sender, amount);
    }

    function borrow(uint256 amount) external {
        if (amount == 0) revert InvalidAmount();
        debt[msg.sender] += amount;
        if (!_healthy(msg.sender)) revert UnhealthyPosition();
        debtToken.safeTransfer(msg.sender, amount);
    }

    function repay(uint256 amount) external {
        if (amount == 0 || amount > debt[msg.sender]) revert InvalidAmount();
        debt[msg.sender] -= amount;
        debtToken.safeTransferFrom(msg.sender, address(this), amount);
    }

    function liquidate(address borrower, uint256 repayAmount) external returns (uint256 seizedCollateral) {
        if (_healthy(borrower)) revert HealthyPosition();
        if (repayAmount == 0 || repayAmount > debt[borrower]) revert InvalidAmount();

        uint256 price = _price();
        uint256 seizeValue = Math.mulDiv(repayAmount, WAD + liquidationBonusWad, WAD);
        seizedCollateral = Math.mulDiv(seizeValue, WAD, price);
        if (seizedCollateral > collateral[borrower]) revert InsufficientCollateral();

        debt[borrower] -= repayAmount;
        collateral[borrower] -= seizedCollateral;
        debtToken.safeTransferFrom(msg.sender, address(this), repayAmount);
        collateralToken.safeTransfer(msg.sender, seizedCollateral);
    }

    function healthFactor(address account) external view returns (uint256) {
        uint256 accountDebt = debt[account];
        if (accountDebt == 0) return type(uint256).max;
        uint256 adjustedCollateral = Math.mulDiv(collateralValue(account), liquidationThresholdWad, WAD);
        return Math.mulDiv(adjustedCollateral, WAD, accountDebt);
    }

    function collateralValue(address account) public view returns (uint256) {
        return Math.mulDiv(collateral[account], _price(), WAD);
    }

    function _healthy(address account) internal view returns (bool) {
        uint256 accountDebt = debt[account];
        if (accountDebt == 0) return true;
        return Math.mulDiv(collateralValue(account), liquidationThresholdWad, WAD) >= accountDebt;
    }

    function _price() internal view returns (uint256 price) {
        price = oracle.priceWad();
        if (price == 0) revert InvalidPrice();
    }
}
