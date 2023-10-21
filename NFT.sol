// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTCollection is ERC721, Ownable(msg.sender) {
    uint256 public constant MAX_NFT_SUPPLY = 1000;
    string private _baseTokenURI;
    mapping(uint256 => string) private _tokenURIs;
    uint256 private _nftCount;

    constructor(string memory name, string memory symbol, string memory baseTokenURI) ERC721(name, symbol) {
        _baseTokenURI = baseTokenURI;
    }

    // Placeholder for uploading metadata to IPFS or on-chain
    function uploadMetadata(string memory metadata) public onlyOwner {
        // Implement metadata upload logic here
    }

    function mintNFT(address to, string memory tokenURI) public onlyOwner {
        require(_nftCount < MAX_NFT_SUPPLY, "Maximum NFT supply reached");
        uint256 tokenId = _nftCount + 1;
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        _nftCount++;
    }

    // Placeholder for writing tests in Hardhat
    function runTests() public onlyOwner {
        // Implement your tests using Hardhat here
    }

    function setNFTTokenURI(uint256 tokenId, string memory tokenURI) public onlyOwner {
        require(_exists(tokenId), "Token with this ID does not exist");
        _setTokenURI(tokenId, tokenURI);
    }

    function getBaseTokenURI() public view returns (string memory) {
        return _baseTokenURI;
    }

    function _setTokenURI(uint256 tokenId, string memory tokenURI) internal {
        require(_exists(tokenId), "Token with this ID does not exist");
        _tokenURIs[tokenId] = tokenURI;
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "Token with this ID does not exist");
        string memory baseURI = getBaseTokenURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, _tokenURIs[tokenId])) : _tokenURIs[tokenId];
    }

    function replaceNFTTokenURI(uint256 tokenIdToReplace, string memory newTokenURI) public onlyOwner {
        require(_exists(tokenIdToReplace), "Token with this ID does not exist");
        _setTokenURI(tokenIdToReplace, newTokenURI);
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        return tokenId >= 1 && tokenId <= _nftCount;
    }
}