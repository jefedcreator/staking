//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./IERC721.sol";
import "./IERC20.sol";

contract stakeboredToken{

    struct staker{
        uint64 stakeAmount;
        uint64 stakeTime;
        address skater;
    }

    mapping(address => staker) stakers;

    IERC721 boredApe = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);
    IERC20 boredToken = IERC20(0x4bf010f1b9beDA5450a8dD702ED602A104ff65EE);

    function receiveToken() internal returns (bool) {
        require(boredApe.balanceOf(msg.sender) > 0, "You need to own a bored ape");
        (bool status) = boredToken.transfer(msg.sender, 100);
        return status;
    }

    function stake(uint amount) public returns (bool){
        receiveToken();
        require(amount <= 100,"cannot stake more than 100 tokens");
        staker storage staking = stakers[msg.sender];
        staking.stakeAmount = amount;
        staking.skater = msg.sender;
        staking.stakeTime = block.timestamp;
        (bool status) = boredToken.transferFrom(msg.sender,address(this),amount);
        return status;
    }

    function withdraw(uint withdrawAmount) public returns(bool) {
        staker storage s =  stakers[msg.sender];
        uint64 daysPassed = (block.timestamp - s.stakeTime);
        if(s.stakeTime > 253,800){
            uint reward = s.stakeAmount * 385 * timePassed;
            s.stakeAmount += reward/10**10;
        }
        require(withdrawAmount <= s.balance, "you can only withdraw within your reward");
        s.balance -=withdrawAmount;
        s.stakeTime =uint64(block.timestamp);
        (bool status) = boredToken.transfer(msg.sender, withdrawAmount);
        return status;
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