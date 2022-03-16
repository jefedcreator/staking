//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IERC721{
    function balanceOf(address _owner) external view returns (uint256);
}

contract boredApeToken is ERC20, Ownable{
    constructor() ERC20("boredApeToken", "brt") {
        _mint(msg.sender, 10*10**18);
    }

    // function mintToken(uint256 amount) public onlyOwner {
    //     // _mint(msg.sender, amount*decimal);
    // }

    
}