// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/// @title StakingRewards
/// @notice Fixed-duration staking rewards using index-based accounting.
contract StakingRewards is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    error ZeroAddress();
    error ZeroAmount();
    error InsufficientBalance();
    error RewardPeriodActive();
    error InvalidRewardsDuration();
    error InsufficientRewardBalance();

    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardToken;

    uint256 public rewardsDuration = 7 days;
    uint256 public periodFinish;
    uint256 public rewardRate;
    uint256 public lastUpdateTime;
    uint256 public rewardPerTokenStored;
    uint256 public totalStaked;

    mapping(address => uint256) public balanceOf;
    mapping(address => uint256) public userRewardPerTokenPaid;
    mapping(address => uint256) public rewards;

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event RewardPaid(address indexed user, uint256 amount);
    event RewardAdded(uint256 amount);
    event RewardsDurationUpdated(uint256 duration);

    constructor(address initialOwner, IERC20 stakingToken_, IERC20 rewardToken_) Ownable(initialOwner) {
        if (initialOwner == address(0)) revert ZeroAddress();
        if (address(stakingToken_) == address(0) || address(rewardToken_) == address(0)) {
            revert ZeroAddress();
        }

        stakingToken = stakingToken_;
        rewardToken = rewardToken_;
    }

    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = lastTimeRewardApplicable();

        if (account != address(0)) {
            rewards[account] = earned(account);
            userRewardPerTokenPaid[account] = rewardPerTokenStored;
        }
        _;
    }

    /// @notice Stakes `amount` staking tokens.
    /// @param amount Amount of staking tokens to deposit.
    function stake(uint256 amount) external nonReentrant updateReward(msg.sender) {
        if (amount == 0) revert ZeroAmount();

        totalStaked += amount;
        balanceOf[msg.sender] += amount;

        stakingToken.safeTransferFrom(msg.sender, address(this), amount);
        emit Staked(msg.sender, amount);
    }

    /// @notice Withdraws `amount` staking tokens.
    /// @param amount Amount of staking tokens to withdraw.
    function withdraw(uint256 amount) public nonReentrant updateReward(msg.sender) {
        if (amount == 0) revert ZeroAmount();
        if (balanceOf[msg.sender] < amount) revert InsufficientBalance();

        totalStaked -= amount;
        balanceOf[msg.sender] -= amount;

        stakingToken.safeTransfer(msg.sender, amount);
        emit Withdrawn(msg.sender, amount);
    }

    /// @notice Claims all earned rewards for the caller.
    function getReward() public nonReentrant updateReward(msg.sender) {
        uint256 reward = rewards[msg.sender];
        if (reward == 0) {
            return;
        }

        rewards[msg.sender] = 0;
        rewardToken.safeTransfer(msg.sender, reward);

        emit RewardPaid(msg.sender, reward);
    }

    /// @notice Withdraws the caller's full stake and claims rewards.
    function exit() external {
        withdraw(balanceOf[msg.sender]);
        getReward();
    }

    /// @notice Starts or tops up a reward period. Reward tokens must be funded before calling.
    /// @param reward Amount of reward tokens to distribute over rewardsDuration.
    function notifyRewardAmount(uint256 reward) external onlyOwner updateReward(address(0)) {
        if (reward == 0) revert ZeroAmount();

        if (block.timestamp >= periodFinish) {
            rewardRate = reward / rewardsDuration;
        } else {
            uint256 remaining = periodFinish - block.timestamp;
            uint256 leftover = remaining * rewardRate;
            rewardRate = (reward + leftover) / rewardsDuration;
        }

        uint256 availableRewards = rewardToken.balanceOf(address(this));
        if (address(rewardToken) == address(stakingToken)) {
            if (availableRewards < totalStaked) revert InsufficientRewardBalance();
            availableRewards -= totalStaked;
        }

        if (rewardRate == 0 || rewardRate > availableRewards / rewardsDuration) {
            revert InsufficientRewardBalance();
        }

        lastUpdateTime = block.timestamp;
        periodFinish = block.timestamp + rewardsDuration;

        emit RewardAdded(reward);
    }

    /// @notice Updates the reward period duration after the current period has finished.
    /// @param rewardsDuration_ New reward duration in seconds.
    function setRewardsDuration(uint256 rewardsDuration_) external onlyOwner {
        if (block.timestamp <= periodFinish) revert RewardPeriodActive();
        if (rewardsDuration_ == 0) revert InvalidRewardsDuration();

        rewardsDuration = rewardsDuration_;
        emit RewardsDurationUpdated(rewardsDuration_);
    }

    /// @notice Returns the timestamp used for reward accounting.
    /// @return Timestamp capped at periodFinish.
    function lastTimeRewardApplicable() public view returns (uint256) {
        return block.timestamp < periodFinish ? block.timestamp : periodFinish;
    }

    /// @notice Returns accumulated reward per staked token.
    /// @return Reward per staked token scaled by 1e18.
    function rewardPerToken() public view returns (uint256) {
        if (totalStaked == 0) {
            return rewardPerTokenStored;
        }

        return rewardPerTokenStored
            + ((lastTimeRewardApplicable() - lastUpdateTime) * rewardRate * 1e18) / totalStaked;
    }

    /// @notice Returns total earned rewards for `account`.
    /// @param account Account to inspect.
    /// @return Total claimable rewards.
    function earned(address account) public view returns (uint256) {
        return ((balanceOf[account] * (rewardPerToken() - userRewardPerTokenPaid[account])) / 1e18)
            + rewards[account];
    }
}
