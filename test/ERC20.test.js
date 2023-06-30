const Token20= artifacts.require("MyErc20Token");
contract("ERC20 Testing" , (accounts)=>{

    let myToken;
    const minter= accounts[0];

    before(async ()=>{
        myToken= await Token20.new();
    })

    it("Should mint the token", async()=>{
        
        const amount = web3.utils.toWei("1000", "ether");
        await myToken.mint(minter,1000);
        const balance= await myToken.balanceOf(minter);
        console.log(balance.toString());
        // console.log(typeof balance)
        assert.equal(balance.toString(), amount, "Incorrect balance after minting")
    })
})