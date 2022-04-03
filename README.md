# ComposeIT

## Problem Statement 
A platform where artists can share music as NFTs. Since record labels take a majority of the cut of music artists, this could be a more direct way for artists to share their music with their fans.

## Our solution 

- Mint NFTs storing music data
- Ensure originality and uniqueness by checking hash
- Play back the songs registered on blockchain
- Bootstraped with Truffle,
and deployed on Polygon, Ropsten, and Rinkeby
([deployed_address.txt](./deployed_address.txt))
- React app built with [next.js](https://github.com/vercel/next.js/) 

## How to use

- Sign in with Ethereum provider
- Browe songs and see metadata (title, composer account)
- Play songs
  - by selecting one from the list
  - or accessing directly via link
- Buy ComposeIt token to pay for minting new songs
- Write a new song and mint it as NFT
- Access them on NFT marketplaces like OpenSea

## Install and migration

```sh
# install frontend dependencies, smart contract tooling, and solidity libraries
yarn install

# deploy smart contracts to local network
ganache-cli -p 8545 # or Ganache GUI
truffle migrate
```