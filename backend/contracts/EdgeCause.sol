// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract EdgeCause is ERC721 {
    using SafeMath for uint256;
    using Counters for Counters.Counter;

    struct Campaign {
        address donor;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address[] donators;
        uint256[] donations;
    }

    address public owner;

    mapping(uint256 => Campaign) public campaigns;

    Counters.Counter private _tokenIds;
    mapping(uint256 => uint256) public nftDonationAmounts;

    uint256 public numberOfCampaigns = 0;

    constructor(string memory _name, string memory _symbol) 
        ERC721("EdgeCause NFT", "ECNFT") {
            owner = msg.sender;
        }

    function createCampaign(address _donor, string memory _title, string memory _description, uint256 _target, uint256 _deadline, string memory _image) public returns (uint256) {
        Campaign storage campaign = campaigns[numberOfCampaigns];

        require(campaign.deadline < block.timestamp, "The deadline should be a date in the future.");

        campaign.donor = _donor;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;
        campaign.image = _image;

        numberOfCampaigns++;

        return numberOfCampaigns - 1;
    }

    function donateToCampaign(uint256 _id) public payable {
        uint256 amount = msg.value;

        Campaign storage campaign = campaigns[_id];

        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);

        (bool sent,) = payable(campaign.donor).call{value: amount}("");

        if(sent) {
            campaign.amountCollected = campaign.amountCollected + amount;

            if (amount >= 1 ether) {
                _tokenIds.increment();
                uint256 newTokenId = _tokenIds.current();
                _safeMint(msg.sender, newTokenId);
                nftDonationAmounts[newTokenId] = amount;
            }
        }
    }

    function getDonators(uint256 _id) view public returns (address[] memory, uint256[] memory) {
        return (campaigns[_id].donators, campaigns[_id].donations);
    }

    function getCampaigns() public view returns (Campaign[] memory) {
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns);

        for(uint i = 0; i < numberOfCampaigns; i++) {
            Campaign storage item = campaigns[i];

            allCampaigns[i] = item;
        }

        return allCampaigns;
    }
}
