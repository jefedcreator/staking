//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

interface IERC721{
    function balanceOf(address _owner) external view returns (uint256);
}

abstract contract BoredApe is IERC721{
    function checkBal(address _boredApe, address _owner) public view{
        IERC721(_boredApe).balanceOf(_owner);
    }
}
