const EeeAreCee20Token = artifacts.require("EeeAreCee20Token");

module.exports = function (deployer) {
  deployer.deploy(EeeAreCee20Token, 10);
};
