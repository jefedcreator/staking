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
        require(receiveToken(), "you need bored Tokens to stake");
        require(amount <= 100,"cannot stake more than 100 tokens");
        staker storage staking = stakers[msg.sender];
        staking.stakeAmount = uint64(amount);
        staking.skater = msg.sender;
        staking.stakeTime = uint64(block.timestamp);
        (bool status) = boredToken.transferFrom(msg.sender,address(this),amount);
        return status;
    }

    function withdraw(uint64 withdrawAmount) public returns(bool) {
        staker storage s =  stakers[msg.sender];
        uint64 timePassed = (uint64(block.timestamp) - s.stakeTime);
        if(s.stakeTime > 253800){
            uint reward = s.stakeAmount * 385 * timePassed;
            s.stakeAmount += uint64(reward/10**10);
        }
        require(withdrawAmount <= s.stakeAmount, "you can only withdraw within your reward");
        s.stakeAmount -=withdrawAmount;
        s.stakeTime =uint64(block.timestamp);
        (bool status) = boredToken.transfer(msg.sender, withdrawAmount);
        return status;
        // stake(s.balance);
    }

    function autoCompound(uint64 coumpound) public{
        staker storage s =  stakers[msg.sender];
        require(s.stakeAmount != 0, "Please stake first");
        uint autoCompoundAmount = s.stakeAmount += coumpound;
        stake(autoCompoundAmount);
    }

    function viewStake() public view returns(staker memory){
        return stakers[msg.sender];
    }
}