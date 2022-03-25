//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IERC721{
    function balanceOf(address _owner) external view returns (uint256);
}
