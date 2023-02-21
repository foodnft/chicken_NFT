//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./contracts/access/Ownable.sol";

contract TheNFT is ERC721Enumerable, Ownable {
    using Strings for uint256;

    string public baseURI;
    string public baseExtension = ".json";
    
    
    uint256 public maxSupply = 2500;
    

    bool public paused = false;
    mapping(address => bool) public whitelisted;

    //its declared public so can track the age of the NFT
    // tokenID of NFT => age
    mapping(uint256 => uint256) public age;

    constructor(
        //Broasted Chicken House
        string memory _name,
        //BCH
        string memory _symbol,
        //https://gateway.pinata.cloud/ipfs/QmVBUF2qk4GPVf1ce9YLAx7i6hfXKMwB35WVh2beWbH97e/
        string memory _initBaseURI
    ) ERC721(_name, _symbol) {
        setBaseURI(_initBaseURI);
        mint(msg.sender, 1);
    }
    
    function changeAge(uint256 _tokenID, uint256 _age) public onlyOwner {

        age[_tokenID] = _age;
        //age == 1 // nesting period // 7 days
        //age == 2 // egg // 7 days
        //age == 3 // baby chick // 7 days
        //age == 4 // half grown chick // 10 days
        //age == 5 // full chicken
    }

    // internal
    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    // public
    function mint(address _to, uint256 _mintAmount) public onlyOwner {
        _mintAmount == 1;
        uint256 supply = totalSupply();
        require(!paused); // true
        require(_mintAmount >= 1);
        require(supply + _mintAmount <= maxSupply);
        for (uint256 i = 1; i <= _mintAmount; i++) {
            _safeMint(_to, supply + i);
        }
    }

    function walletOfOwner(address _owner)
        public
        view
        returns (uint256[] memory)
    {
        uint256 ownerTokenCount = balanceOf(_owner);
        uint256[] memory tokenIds = new uint256[](ownerTokenCount);
        for (uint256 i; i < ownerTokenCount; i++) {
            tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
        }
        return tokenIds;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory currentBaseURI = _baseURI();
        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        tokenId.toString(),
                        baseExtension
                    )
                )
                : "";
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    function setBaseExtension(string memory _newBaseExtension)
        public
        onlyOwner
    {
        baseExtension = _newBaseExtension;
    }

    function pause(bool _state) public onlyOwner {
        paused = _state;
    }

    function whitelistUser(address _user) public onlyOwner {
        whitelisted[_user] = true;
    }

    function removeWhitelistUser(address _user) public onlyOwner {
        whitelisted[_user] = false;
    }


    function withdraw() public payable onlyOwner {
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success);
    }
}
