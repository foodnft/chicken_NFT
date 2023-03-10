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

    uint256 public newAge = 1620000000;

    uint256 public age = 0;
    uint256 nesting = 0;
    constructor(
        string memory _name,
        string memory _symbol,
        string memory _initBaseURI
    ) ERC721(_name, _symbol) {
        setBaseURI(_initBaseURI);
        mint(msg.sender, 1);
    }

    //age
    function checkAge() public view returns (uint256) {
        return block.timestamp - 1620000000;
    }

    function changeAge(uint256 _tokenURI) public onlyOwner {
        newAge = block.timestamp;

        nesting = age + 604800;
        nesting = age + 604800;

        for(uint256 i = 0; i <= 5; i++) {
            nesting = nesting + 604800;
        }
        //AGE == 0 // nesting period // 7 days
        //AGE == 1 // egg // 7 days
        //AGE == 2 // baby chick // 7 days
        //AGE == 3 // half grown chick // 10 days
        //AGE == 4 // full chicken
    }

    function nest() public {

        require(checkAge() >= 86400);
        
    }

    // internal
    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    // public
    function mint(address _to, uint256 _mintAmount) public payable {
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
