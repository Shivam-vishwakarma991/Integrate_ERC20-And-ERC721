const migrations = artifacts.require("MapERC20withERC21");
const MyErc20Token = artifacts.require("MyErc20Token");

module.exports = async function(deployer, network, accounts) {
  await deployer.deploy(MyErc20Token);
  const myErc20TokenInstance = await MyErc20Token.deployed();

  deployer.deploy(migrations, myErc20TokenInstance.address);
};
