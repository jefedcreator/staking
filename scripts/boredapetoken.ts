// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  // const stakeboredapetoken = "0x4bf010f1b9beDA5450a8dD702ED602A104ff65EE";
  const deployedToken = "0x4bf010f1b9beDA5450a8dD702ED602A104ff65EE";
  const deployedStake = "0x40a42Baf86Fc821f972Ad2aC878729063CeEF403";
  const boredApeToken = await ethers.getContractAt("boredApeToken",deployedToken);
  // const deployboredApeToken = await boredApeToken.deploy();

  // await deployboredApeToken.deployed;
  //console.log("balance",await deployboredApeToken.balanceOf(deployboredApeToken.address))
  // console.log("allowance",await deployboredApeToken.allowance(deployboredApeToken.address, deployboredApeToken.address))
  await boredApeToken.transferBoredApeToken(
    deployedStake,
    10000
  );

  console.log("boredApeToken deployed to:", boredApeToken.address);
  console.log("boredApeToken balance of staker contract",await boredApeToken.balanceOf(deployedStake))
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
