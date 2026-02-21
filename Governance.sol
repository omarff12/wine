// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Governance {
    IERC20 public governanceToken;
    mapping(address => bool) public voters;

    constructor(IERC20 _governanceToken) {
        governanceToken = _governanceToken;
    }

    function vote(bool approve) external {
        require(governanceToken.balanceOf(msg.sender) > 0, "No governance tokens");
        voters[msg.sender] = approve;
    }
}
