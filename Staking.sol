// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Staking {
    IERC20 public stakingToken;
    uint256 public rewardRate = 1000; // Example reward rate
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public rewards;

    constructor(IERC20 _stakingToken) {
        stakingToken = _stakingToken;
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        stakingToken.transferFrom(msg.sender, address(this), amount);
        stakes[msg.sender] += amount;
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Not enough staked tokens");
        stakes[msg.sender] -= amount;
        stakingToken.transfer(msg.sender, amount);
    }

    function claimRewards() external {
        uint256 reward = stakes[msg.sender] * rewardRate / 100;
        rewards[msg.sender] += reward;
        stakingToken.transfer(msg.sender, reward);
    }
}
