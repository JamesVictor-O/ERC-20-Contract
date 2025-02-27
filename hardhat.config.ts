import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-verify";


import dotenv from "dotenv";

dotenv.config();


const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks: {
    "sepolia": {
      url: process.env.ALCHEMY_API_KEY!,
      accounts:[process.env.ACCOUNT_PRIVATE_KEY!],
      chainId: 11155111,
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY!, 
  },
};
export default config;

