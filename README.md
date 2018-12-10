# Skullys Contract

## Getting started
First you need to install all of the requirements to run truffle and a local testrpc.

- `npm install -g truffle ganache-cli` to install Truffle and Ganache-cli.
- `npm install` to install npm requirements.

Truffle will use the "development" network by default.  This assumes that you are running a testrpc on localhost at port 8545.

## Running the tests
- `truffle test --network test`


## Developing on the Test App

To run the blockchain and app locally:

- In a separate window, run `ganache-cli`.  It should now be running locally on port 8545.
- `truffle migrate --reset --build-all` to build and deploy the Skullys.sol contract.
- `npm run dev` to start up the web server.  The app should be running locally on port 300.
- Copy the `(0)` private key and import it into Meta Mask in your browser.  This is the default account that Tokens will be minted to.  You should have around ~97 ETH to
play with.

## Deploying the contract

- `truffe migrate --reset --compile-all --network ropsten` to compile the contract code and deploy it to ropsten.
## See also
