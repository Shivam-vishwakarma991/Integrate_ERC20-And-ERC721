//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

interface ERc20{
     function mint(address minter, uint amount) external;
     function transferFrom(address from, address to, uint amnt) external returns(bool);
}

contract MapERC20withERC21 is ERC721 {
  // Mapping to track the ERC20 token balance for each ERC721 token

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address private ERC20Contract;  //  Declaring a variable of ERC20 type

    mapping (uint=>uint) private _ERC20Balances;  //Mapping to track the ERC20 token balance for each ERC721 token Its key is tokenID and Value is the tokens

    event TokenMinted(address indexed owner, uint indexed tokenId);

    constructor(address ERC20Address) ERC721("Token721", "TKN"){
        ERC20Contract = ERC20Address;

        // constructor takes an address parameter ERc20Address, which represents the address of the ERC20 contract.

// The line ERC20Contract = ERC20(ERC20Address) assigns the instance of the ERC20 contract at the provided address ERC20Address to the ERC20Contract variable.

// By storing an instance of the ERC20 contract, the ERC721 contract can use the ERC20Contract variable to call functions like transferFrom to transfer ERC20 tokens between tokens of the ERC721 contract.

    }

    function Mint() public{
        
        _tokenIds.increment();
        uint newTokenId= _tokenIds.current();
        _mint(msg.sender, newTokenId);
        _ERC20Balances[newTokenId]= 1000;
        ERc20(ERC20Contract).mint(msg.sender,1000);  
        emit TokenMinted(msg.sender, newTokenId);
    }

    function getERC20BALance(uint tokenID) public view returns(uint){
        require(_exists(tokenID), "ERC721 Token dont exist");
        return _ERC20Balances[tokenID];
    }


    function TransferERC20(uint fromID, uint ToID,uint amnt) public{
        require(_exists(fromID), "From ERC721 token does not exist");
        require(_exists(ToID), "To ERC721 token does not exist");
        require(_ERC20Balances[fromID] >= amnt, "Insufficient ERC20 balance");
address to = ownerOf(ToID);
        _ERC20Balances[fromID]-= amnt;
        _ERC20Balances[ToID]+= amnt;
         ERc20(ERC20Contract).transferFrom(msg.sender,to, amnt );
        //ERC20Contract.transferFrom(msg.sender, address(this), amnt);
    }
}