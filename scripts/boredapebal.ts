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
    const BORED_APE = "0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D";
    const BORED_OWNER = "0x1d565f170d45c192fb9f454a14110dcc88e0cc44";

  const boredBal = await ethers.getContractAt("IERC721",BORED_APE);
  const deployBoredBal = await boredBal.balanceOf(BORED_OWNER);
//   const deployedBoredBal = await deployBoredBal.deployed();
  
  console.log(deployBoredBal);
  


//   console.log("Bored Bal deployed to:", deployBoredBal.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
