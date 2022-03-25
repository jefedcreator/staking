// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { Signer } from "ethers";
import { ethers } from "hardhat";

const boredApeHolder = "0x8BBc693D042cEA740e4ff01D7E0Efb36110c36BF";

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const deployedStake = "0x40a42Baf86Fc821f972Ad2aC878729063CeEF403";
  const deployedToken = "0x4bf010f1b9beDA5450a8dD702ED602A104ff65EE";
  const stakeboredapetokenInteract = await ethers.getContractAt("stakeboredToken",deployedStake);
  const boredapetokenInteract = await ethers.getContractAt("boredApeToken",deployedToken);
  // const deploystakeboredapetoken = await stakeboredapetokenInteract.deploy();

  // await deploystakeboredapetoken.deployed();

  //impersonate BAYC owner
  //@ts-ignore
  await hre.network.provider.request({
    method: "hardhat_impersonateAccount",
    params: [boredApeHolder],
  });

  const signer:Signer = await ethers.getSigner(boredApeHolder);

  console.log("deploystakeboredapetoken deployed to:", stakeboredapetokenInteract.address);
  
  stakeboredapetokenInteract.connect(signer).receiveToken();

  console.log("bored ape token balance of BAYC hodler",await boredapetokenInteract.balanceOf(boredApeHolder));

  //getting ready to stake
  //approve staker contract to transfer from
  await boredapetokenInteract.connect(signer).approve(
    stakeboredapetokenInteract.address,
    "1000000000"
  );
  console.log("Approval succesful");
  

 //stake 10 tokens
//  await stakeboredapetokenInteract.connect(signer).stake(10);
//  console.log("stake succesful");

 //withdraw from contract
 await stakeboredapetokenInteract.connect(signer).withdraw(10);
 console.log("withdraw succesful");

 //autocompound
 await stakeboredapetokenInteract.connect(signer).autoCompound(10);
 console.log("autocompound succesful");

 //view my stake
 console.log("view accounts stake:",await stakeboredapetokenInteract.viewStake());
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
