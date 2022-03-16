//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IERC721{
    function balanceOf(address _owner) external view returns (uint256);
}

contract boredToken is ERC20, Ownable{

    address boredApe = 0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D;

    constructor() ERC20("boredApeToken", "brt") {
        
    }

    // function mintToken(uint256 amount) public onlyOwner {
    //     // _mint(msg.sender, amount*decimal);
    // }

    function checkBal(address _eoa ) public view returns(bool status){
        return status = (IERC721(boredApe).balanceOf(_eoa) > 0);
    }

    function mint() public {
        require(checkBal(msg.sender), "this address does not own a BAYC");
        _mint(msg.sender, 10*10**18);
    }

    function stake(uint amount) public payable{
        _transfer(msg.sender,address(this),amount);
        _approve(msg.sender,address(this),amount);
        uint currentTime = block.timestamp;
        uint investTime = block.timestamp + 3 days;
        uint months = (block.timestamp + 30) % 30;
        if(investTime > currentTime){
            amount = (10 * amount * months) / 100;
        }
    }

    function withdraw() public{
        
    }
}