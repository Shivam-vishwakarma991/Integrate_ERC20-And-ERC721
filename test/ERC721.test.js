const MyErc20Token = artifacts.require("MyErc20Token");
const MyErc721Token = artifacts.require("MapERC20withERC21");
const truffleAssert = require("truffle-assertions");



contract("MyErc721Token", (accounts) => {
    let erc20Token;
    let erc721Token;
    const tokenOwner = accounts[0];
    const minter = accounts[1];
    before(async () => {
      erc20Token = await MyErc20Token.new();
      erc721Token = await MyErc721Token.new(erc20Token.address);
    //   console.log(erc721Token)
    });
  
    it("should mint a new ERC721 token and verify ownership and ERC20 balance", async () => {
      const tokenId = 1;
      const amount = web3.utils.toWei("1000", "ether");
  
      
      await erc721Token.Mint();
  
      const owner = await erc721Token.ownerOf(tokenId);
      assert.equal(owner, tokenOwner, "Incorrect token ownership");
  
      const balance = await erc20Token.balanceOf(tokenOwner);
      console.log(balance.toString())
      assert.equal(balance.toString(), amount, "Incorrect ERC20 balance");
    });
 
  
});
 