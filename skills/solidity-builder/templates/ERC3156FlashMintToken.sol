// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20FlashMint} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20FlashMint.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title ERC3156FlashMintToken
/// @notice Capped ERC20 with ERC3156 flash-mint support.
contract ERC3156FlashMintToken is ERC20, ERC20FlashMint, Ownable {
    error ZeroAddress();
    error CapExceeded();
    error FeeTooHigh();

    uint256 public constant BPS_DENOMINATOR = 10_000;
    uint256 public immutable maxSupply;

    address public flashFeeReceiver;
    uint256 public flashFeeBps;

    event FlashFeeUpdated(address indexed receiver, uint256 feeBps);

    constructor(
        string memory name_,
        string memory symbol_,
        address initialOwner,
        address initialRecipient,
        uint256 initialSupply,
        uint256 maxSupply_
    ) ERC20(name_, symbol_) Ownable(initialOwner) {
        if (initialOwner == address(0) || initialRecipient == address(0)) revert ZeroAddress();
        if (initialSupply > maxSupply_) revert CapExceeded();

        maxSupply = maxSupply_;
        flashFeeReceiver = initialOwner;
        _mint(initialRecipient, initialSupply);
    }

    function setFlashFee(address receiver, uint256 feeBps) external onlyOwner {
        if (receiver == address(0)) revert ZeroAddress();
        if (feeBps > BPS_DENOMINATOR) revert FeeTooHigh();

        flashFeeReceiver = receiver;
        flashFeeBps = feeBps;
        emit FlashFeeUpdated(receiver, feeBps);
    }

    function maxFlashLoan(address token) public view override returns (uint256) {
        if (token != address(this)) {
            return 0;
        }
        return maxSupply - totalSupply();
    }

    function _flashFee(address, uint256 value) internal view override returns (uint256) {
        return (value * flashFeeBps) / BPS_DENOMINATOR;
    }

    function _flashFeeReceiver() internal view override returns (address) {
        return flashFeeReceiver;
    }
}
