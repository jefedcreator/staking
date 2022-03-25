//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IERC20{
    function balanceOf(address _owner) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}