var cotization_oracle = artifacts.require("./cotization_oracle.sol");

module.exports = function(deployer) {
  deployer.deploy(cotization_oracle);
};
