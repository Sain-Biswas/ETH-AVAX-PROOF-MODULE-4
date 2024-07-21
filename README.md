
# Degen Gaming Tokens

Repository for Module 4 of Eth Avax Proof - Interediate EVM Course


## Description
In this repository you will get the source code for deploying a ERC20 Token on avalanche network.
## Documentation

### Introduction to Avalanche
Avalanche has become increasingly popular due to the platform's unique features. As the first decentralized smart contracts platform built for the scale of global finance, Avalanche offers near-instant transaction finality, low fees, and high scalability. The Avalanche platform is composed of multiple "chains" or subnets:

- *Exchange Chain*, or the X-Chain, is responsible for operations on digital smart assets known as Avalanche Native Tokens.

- *Contract Chain*, or the C-Chain, is an implementation of the Ethereum Virtual Machine (EVM) and supports the creation and execution of smart contracts written in Solidity.

- *Platform Chain*, or the P-Chain, supports the creation of new blockchains and Subnets, the addition of validators to Subnets, staking operations, and other platform-level operations.

The Avalanche network has its native token called AVAX, the native token secures the network, pays for fees, and provides the basic unit of account between the multiple blockchains deployed on the larger Avalanche network.

In this guide we are going to set up a basic project using the [Hardhat](https://hardhat.org/), we are going to connect it to the Avalanche C-Chain and we are going to deploy a WAVAX (ERC20) smart contract, we are going to interact with it on [Snowtrace](https://snowtrace.io/) (Avalanche's native block explorer) and using custom scripts on Hardhat.

### Avalanche X-Chain
The X-Chain is responsible for operations on digital smart assets known as Avalanche Native Tokens. These tokens could be used to represent a wide range of assets, including cryptocurrencies, stocks, bonds, and real estate. The [X-Chain API](https://docs.avax.network/apis/avalanchego/apis/x-chain) provides a simple and easy-to-use interface for creating and trading these tokens.

One of the key benefits of the X-Chain is its high throughput and low transaction fees. Additionally, the X-Chain supports atomic swaps, which allow users to exchange one asset for another without the need for a centralized exchange or intermediary.

### Avalanche P-Chain
The P-Chain is a platform chain on Avalanche, responsible for the creation and management of new blockchains and subnets, the addition of validators to subnets, and other platform-level operations. The P-Chain is also responsible for staking operations, which are used to secure the network and maintain consensus across all the subnets on the Avalanche network.

Staking on the P-Chain involves locking up AVAX tokens as collateral to become a validator, or delegating AVAX tokens to an existing validator to participate in the consensus process. Validators are responsible for verifying transactions and adding new blocks to the chain and are rewarded with AVAX tokens for their work.

In addition to staking, the P-Chain also supports the creation of custom subnets, which are separate chains that can have their own unique set of rules and parameters. These subnets can be used for a variety of purposes, such as creating private networks or implementing specialized execution environments.

Overall, the P-Chain is a key component of the Avalanche platform, providing the infrastructure and governance mechanisms necessary to maintain a secure and decentralized network.

The P-Chain is an instance of the Platform Virtual Machine. The [P-Chain API](https://docs.avax.network/apis/avalanchego/apis/p-chain) supports the creation of new blockchains and Subnets, the addition of validators to Subnets, staking operations, and other platform-level operations.

### Avalanche C-Chain
The C-Chain is an implementation of the Ethereum Virtual Machine (EVM), which means that it supports the creation and execution of smart contracts written in Solidity. This makes it easy for developers who are already familiar with Ethereum to build and deploy decentralized applications (dApps) on Avalanche.

One of the key benefits of the C-Chain is its high performance and low transaction fees. With its sub-second finality and low gas fees, the C-Chain can support a wide range of dApps with high transaction volumes.

The C-Chain also supports interoperability with other blockchains, including Ethereum, through the use of cross-chain bridges. This means that assets and data can be transferred between the two chains, opening up new possibilities for decentralized finance (DeFi) and other use cases.

The [C-Chain API](https://docs.avax.network/apis/avalanchego/apis/x-chain) provides a similar interface to the Ethereum JSON-RPC API, making it easy for developers to interact with the C-Chain using their existing tools and libraries.

In this guide we're going to interact with the C-Chain, we need to create an ERC20 token to represent Degen Tokens for a gaming studio, we want to enable the studio to mint these tokens according to their needs, so we also need to add simple mint function to our smart contract to mint these tokens to a specific address.


## Run Locally

Clone the project:

```bash
  git clone https://github.com/Sain-Biswas/ETH-AVAX-PROOF-MODULE-4.git
```

Go to the project directory:

```bash
  cd ETH-AVAX-PROOF-MODULE-4
```

Install dependencies:

```bash
  npm install
```

before running the code make sure to make necessary changes to .env and hardhat.config.js according to your alchemy account.

### Verify
One additional step is to verify the deployed smart contract, [to do this we need an API Key from Snowtrace, you need to provide an email address to complete this step, but is straightforward](https://snowtrace.io/register).

Once you have your account set up, you can go to [your API Keys section](https://snowtrace.io/myapikey) and create a key from there.

Once you have your new API key, we can paste it into our Harhat config file, like so:

```javascript
module.exports = {
  // ...rest of the config...
  etherscan: {
    apiKey: "ABCDE12345ABCDE12345ABCDE123456789",
  },
};
```
Now we have access to the *verify* task, which allows us to verify smart contracts on specific networks.

```bash
$ npx hardhat verify <contract address> <arguments> --network <network>
```

### Scripts
We need 1 script, the `deploy.js` script, to deploy our Points token smart contract to the chain that we want.

### Deploy script
First, we are going to implement our mint script, if you are familiar with Hardhat this process is simple, we need to get the DegenToken smart contract, deploy it, and print the address where it was deployed (we need to store that address for the `mint.js` script).

```javascript
const hre = require("hardhat");

async function main() {
  // Get the DegenTokens smart contract
  const Degen = await hre.ethers.getContractFactory("DegenToken");

  // Deploy it
  const degen = await Degen.deploy();
  await degen.deployed();

  // Display the contract address
  console.log(`Degen token deployed to ${degen.address}`);
}

// Hardhat recommends this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
```

Once we are satisfied with the results of our testing on the Fuji test network, we can proceed with deploying our smart contracts to Avalanche's Mainnet. This will require us to modify the configuration file once again to point to the appropriate endpoint for the Mainnet.

In conclusion, configuring Harhat to work with Avalanche by default involves adding Avalanche to its supported chains and specifying the Fuji test network as the default network for testing. Once testing is complete, we can deploy our smart contracts to Avalanche's Mainnet.

### Deploying
Now we need to deploy our smart contract, first, we are going to deploy our Token to testnet, we first need to get some Testnet AVAX from the Faucet, so we will get that first go to [https://faucet.avax.network/](https://faucet.avax.network/).

I'm going to assume that you have a wallet setup on your browser, we now need to connect to the Fuji Testnet, and you need to add the network to your wallet, here is all the information that a wallet like Metamask requires you to connect to a chain.

    *Network Name*: Avalanche Fuji C-Chain
    *New RPC URL*: https://api.avax-test.network/ext/bc/C/rpc
    *ChainID*: 43113
    *Symbol*: AVAX
    *Explorer*: https://testnet.snowtrace.io/

> There is a quick way to connect to the Fuji (C-Chain), there is a `🦊 Add Subnet to Metamask` button, below the main modal in the faucet, if you press it, it will automate the process of adding the network to your wallet.

Once we have this setup, we can get our testnet tokens, be sure that the `Select Network` dropdown is `Fuji (C-Chain)` and that the `Select Token` dropdown is set to `AVAX (Native)`.

Now you can connect your wallet using the `🦊 Connect` button, or you can paste your address directly, remember these are test tokens and have no value but you can only request a few tokens per day. Once all of that is complete, you can request AVAX, it takes a few seconds to be available in your wallet which is fantastic.

Now that we have test tokens we are going to deploy the token to the Fuji (C-Chain) test network, go to your terminal, and type:

```bash
$ npx hardhat run scripts/deploy.js --network fuji
```

> Remember to set your private key on your `hardhat.config.js` file, since Harhdat is going to search there to deploy your smart contract.

You should see something like this printout in the console:
```bash
$ npx hardhat run scripts/deploy.js --network fuji
Points token deployed to <YOUR TOKEN ADDRESS>
```

If you have set up your API key, we can verify the smart contract on Fuji by running the following command:

```bash
$ npx hardhat verify <YOUR TOKEN ADDRESS> --network fuji
```

Now we can go to [https://testnet.snowtrace.io/](https://testnet.snowtrace.io/) and search for our smart contract, using the same address that we used before, and there it is our Degen Token, with a verified contract.

(everything after this is optional)

This is great but we now need to deploy the smart contract to the mainnet, to have it in a completely secure environment.

You need real AVAX for this section, you can use Binance or Coinbase to buy AVAX and transfer it to your wallet address, the same wallet address that you defined in your `hardhat.config.js`, once you have your wallet funded you can run:

```bash
$ npx hardhat run scripts/deploy.js --network mainnet
$ npx hardhat verify <YOUR TOKEN ADDRESS> --network mainnet
```

This will deploy and verify your smart contract, now it's available on Avalanche Mainnet (C-Chain)!!!
## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

`WALLET_PRIVATE_KEY`

`SNOWTRACE_API_KEY`

`TOKEN_ADDRESS`


## Authors

- [Sain Biswas](sain.biswas614@gmail.com)


## License

This project is licensed under the [MIT](https://choosealicense.com/licenses/mit/) License.

