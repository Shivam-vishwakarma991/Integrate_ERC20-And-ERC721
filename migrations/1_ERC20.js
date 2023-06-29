const migrations= artifacts.require("MyErc20Token");

module.exports= function (deployer){
    deployer.deploy(migrations)
}