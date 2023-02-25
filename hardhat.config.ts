import { HardhatUserConfig } from "hardhat/config";
require("dotenv").config();
import "@nomicfoundation/hardhat-toolbox";
// Go to https://www.alchemyapi.io, sign up, create
// a new App in its dashboard, and replace "KEY" with its key
const ALCHEMY_API_KEY = "process.env.ALCHEMY_API_KEY";

// Replace this private key with your Goerli account private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Beware: NEVER put real Ether into testing accounts
const MUMBAI_PRIVATE_KEY = "d1166eaf28d49366c893cb6bdf8cd9fe6f0831a9a445173b7715a5d7e33f6c8d";
const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    mumbai: {
      url: `https://polygon-mumbai.g.alchemy.com/v2/9wYrBqgzaEdDJQ1_flx2Hvs-RRSrO33h`,
      chainId: 80001,
      accounts: ["d1166eaf28d49366c893cb6bdf8cd9fe6f0831a9a445173b7715a5d7e33f6c8d"]
    }
  }
};
//npx hardhat run scripts/deploy.js --network mumbai

export default config;
