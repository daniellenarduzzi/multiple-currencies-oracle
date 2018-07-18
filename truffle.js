require('babel-register')({
  ignore: /node_modules\/(?!zeppelin-solidity)/
});
require('babel-polyfill');

module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*",
    },
    coverage: {
      host: "localhost",
      network_id: "*",
      port: 8545,
      gas: 0xfffffffffff,
      gasPrice: 0x01
    },
    ropsten: {
      host: "localhost",
      network_id: 3,
      port: 8545,
      gas: 2900000
    },
    kovan: {
      host: "kovan.cryptologic.io",
      port: 8787,
      network_id: "*",
      from: "0x44751576b07eee07de3d8d5bfb9c8dd77add1744"
    },
  },
  mocha: {
   useColors: true
  }
};
