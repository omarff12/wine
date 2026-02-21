// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract NFTMarketplace {
    mapping(address => mapping(uint256 => uint256)) public nftPrices; // NFT -> price
    IERC721 public nftContract;

    constructor(IERC721 _nftContract) {
        nftContract = _nftContract;
    }

    function listNFT(uint256 tokenId, uint256 price) external {
        nftPrices[address(nftContract)][tokenId] = price;
    }

    function buyNFT(uint256 tokenId) external payable {
        uint256 price = nftPrices[address(nftContract)][tokenId];
        require(msg.value == price, "Incorrect price");
        address owner = nftContract.ownerOf(tokenId);
        payable(owner).transfer(msg.value);
        nftContract.safeTransferFrom(owner, msg.sender, tokenId);
    }
}
