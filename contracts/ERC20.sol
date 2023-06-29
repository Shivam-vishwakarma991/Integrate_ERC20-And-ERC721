
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyErc20Token is ERC20{
    constructor() ERC20("ERCTOKEN", "ERCT"){}

    //Mint ERC20 token with this function

    function mint(address minter, uint amount) public{
        _mint(minter, amount);
    }
}