//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract boredApeToken is ERC20{
    constructor() ERC20("boredApeToken", "brt") {
        _mint(address(this), 1000000*10**18);
        approve(address(this), 100000 * 10**18);
    }

    function transferBoredApeToken(address _to, uint amount) public{
        _transfer(address(this),_to,amount * 10**18);
    }
}