import { HardhatUserConfig } from "hardhat/config";
require("dotenv").config();
import "@nomicfoundation/hardhat-toolbox";
// Go to https://www.alchemyapi.io, sign up, create
// a new App in its dashboard, and replace "KEY" with its key
const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY;

// Replace this private key with your Goerli account private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Beware: NEVER put real Ether into testing accounts
const MUMBAI_PRIVATE_KEY = process.env.MUMBAI_PRIVATE_KEY;
console.log(MUMBAI_PRIVATE_KEY);
const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    mumbai: {
      url: `https://polygon-mumbai.g.alchemy.com/v2/9wYrBqgzaEdDJQ1_flx2Hvs-RRSrO33h`,
      chainId: 80001,
      accounts: [MUMBAI_PRIVATE_KEY]
    }
  }
};
//npx hardhat run scripts/deploy.js --network mumbai

export default config;
