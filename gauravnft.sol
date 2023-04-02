// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract GauravToken is ERC721, ERC721Enumerable, Pausable, Ownable {
    using Counters for Counters.Counter;
    uint256 maxSupply = 100;
    bool  public allowListMintOpen = false;
    bool public publicMintOpen = false ;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("GauravToken", "GAP") {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs:// Qmaa6TuP2s9pSKczHF4rwWhTKUdygrrDs8RmYYqCjP3H ye/";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function editWindow( bool _allowListMintOpen,bool _publicMintOpen)external onlyOwner{
        publicMintOpen = _publicMintOpen;
        allowListMintOpen = _allowListMintOpen;
    }

    function allowListMint() public payable {
        require(allowListMintOpen,"allowlist window has been closed");
        require(msg.value == 0.001 ether,"INPUT RIGHT VALUE");
        internalMint();
    }

    function publicMint() public payable {
        require(publicMintOpen,"publicmint window has been closed");
        require(msg.value == 0.01 ether,"INPUT RIGHT VALUE";)
        internalMint();
    }

    function internalMint()internal {
        require(totalSupply() <= maxSupply,"we have been sold out";)
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    function withdraw(address _addr)external onlyOwner{
        uint256 balance = address(this).balance;
        payable(_addr).transfer(balance);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        whenNotPaused
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}