//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./IERC721.sol";
import "./IERC20.sol";

contract stakeboredToken{

    struct staker{
        uint stakeAmount;
        uint balance;
        uint reward;
        address skater;
        uint stakeTime;
    }

    mapping(address => staker) stakers;

    IERC721 boredApe = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);
    IERC20 boredToken = IERC20(0x4bf010f1b9beDA5450a8dD702ED602A104ff65EE);

    function receiveToken() public{
        require(boredApe.balanceOf(msg.sender) > 0, "You need to own a bored ape");
        boredToken.transfer(msg.sender, 100);
    }

    function stake(uint amount) public {
        staker storage staking = stakers[msg.sender];
        staking.stakeAmount = amount;
        staking.skater = msg.sender;
        staking.stakeTime = block.timestamp;
        boredToken.transferFrom(msg.sender,address(this),amount);
        // IERC20(boredToken).approve(address(this),amount);
    }

    function withdraw(uint withdrawAmount) public {
       staker storage s =  stakers[msg.sender];
       uint daysPassed = (block.timestamp - s.stakeTime)/ (60);
       uint reward = s.stakeAmount * 10/ 100 * daysPassed;
       if(s.stakeTime > 1 minutes){
           s.reward += reward/30;
       }
       else{
           s.reward = 0;
       }
       s.balance = s.reward + s.stakeAmount;
       require(withdrawAmount <= s.balance, "you can only withdraw within your reward");
       boredToken.transfer(msg.sender, withdrawAmount);
       s.balance -=withdrawAmount;
        // stake(s.balance);
    }

    function autoCompound(uint coumpound) public{
        staker storage s =  stakers[msg.sender];
        require(s.balance != 0, "Please stake first");
        uint autoCompoundAmount = s.balance += coumpound;
        stake(autoCompoundAmount);
    }

    function viewStake() public view returns(staker memory){
        return stakers[msg.sender];
    }
}