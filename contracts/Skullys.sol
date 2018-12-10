pragma solidity ^0.4.24;

import 'openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol';
import 'openzeppelin-solidity/contracts/ownership/Ownable.sol';
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';

/// @title Skullys
/// @author Hoank <hoank@crypton3.com>
/// @notice Skullys ERC721 interface for minting, cloning, and transfering Skullys tokens

contract Skullys is ERC721Full ("SkullysToken", "SKL"), Ownable {
    using SafeMath for uint256;

    struct Skully {
        uint256 price;
        uint256 genes;
        string collorHead;
    }

    Skully [] public skullys;

    bool public isMintable = true;

    modifier mintable {
        require(
            isMintable == true,
            "New skullys are no logger mintable on this contract"
        );
        _;
    }

    constructor () public {
        //if the array is new, skip over the first index.
        if (skullys.length == 0) {
            Skully memory _dummySkully = Skully({
                price: 0,
                genes: 0,
                collorHead: "000000"
                });
            skullys.push(_dummySkully);
        }
    }

    /// @dev mint(): mint a new Gen0 skullys. These are the tokens that other skullys will be "closed form".
    /// @param _to address to mint to.
    /// @param _price price of the skullys
    /// @param _genes gen of the skullys
    /// @param _collorHead collor
    /// @param _tokenURI A URL to the JSON file containing the metadata for the skullys. See metadata.json for an example.
    /// @return the tokenId of the skullys hash been minted. Note that in a transaction only the tx_hash in returned
    function mint(address _to, uint256 _price, uint256 _genes, string _collorHead, string _tokenURI) public mintable onlyOwner returns (uint256 tokenId) {
        Skully memory _skully = Skully({
            price: _price,
            genes: _genes,
            collorHead: _collorHead
            });

        // The new Skully is pushed onto the array and minted
        // note that solidity uses 0 as a default value when an item is not found in a mapping

        tokenId = skullys.push(_skully) - 1;
        _mint(_to, tokenId);
        _setTokenURI(tokenId, _tokenURI);
    }

    /// @dev burn(): Burn skullys token.
    /// @param _owner The owner address of the token to Burn
    /// @param _tokenId The Skullys ID to be burned
    function burn(address _owner, uint256 _tokenId) public onlyOwner {
        delete skullys[_tokenId];
        _burn(_owner, _tokenId);
    }

    /// @dev setMintable(): set the isMintable public variable.  When set to `false`, no new
    ///                     kudos are allowed to be minted or cloned.  However, all of already
    ///                     existing kudos will remain unchanged.
    /// @param _isMintable flag for the mintable function modifier.
    function setMintable(bool _isMintable) public onlyOwner {
        isMintable = _isMintable;
    }

    /// @dev setPrice(): Update the Kudos listing price.
    /// @param _tokenId The Skullys Id.
    /// @param _newPrice The new price of the Skullys.
    function setPrice(uint256 _tokenId, uint256 _newPrice) public onlyOwner {
        Skully memory _skully = skullys[_tokenId];

        _skully.price = _newPrice;
        skullys[_tokenId] = _skully;
    }

    /// @dev setTokenURI(): Set an existing token URI.
    /// @param _tokenId The token id.
    /// @param _tokenURI The tokenURI string.  Typically this will be a link to a json file on IPFS.
    function setTokenURI(uint256 _tokenId, string _tokenURI) public onlyOwner {
        _setTokenURI(_tokenId, _tokenURI);
    }

    /// @dev getSkullyById(): Return a skullys struct/array given a skullys Id.
    /// @param _tokenId The Skullys Id.
    /// @return the Skullys struct, in array form.
    function getSkullyById(uint256 _tokenId) view public returns (uint256 price,
        uint256 genes,
        string collorHead
    )
    {
        Skully memory _skully = skullys[_tokenId];

        price = _skully.price;
        genes = _skully.genes;
        collorHead = _skully.collorHead;
    }

    /// @dev getLatestId(): Returns the newest skullys Id in the skullys array.
    /// @return the latest skullys id.
    function getLatestId() view public returns (uint256 tokenId)
    {
        if (skullys.length == 0) {
            tokenId = 0;
        } else {
            tokenId = skullys.length - 1;
        }
    }

}
