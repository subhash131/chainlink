// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol";

contract FetchProduct is ChainlinkClient, ConfirmedOwner {
    using Chainlink for Chainlink.Request;

    string public FETCH_URL = "";
    string name = "";
    string description = "";
    string image = "";
    string price = "";

    bytes32 private jobId;
    uint256 private fee;

    event Request(bytes32 indexed requestId, string id);
    constructor(string memory _fetchUrl) ConfirmedOwner(msg.sender) {
        FETCH_URL = _fetchUrl;
        setChainlinkToken(0x326C977E6efc84E512bB9C30f76E30c160eD06FB);
        setChainlinkOracle(0x40193c8518BB267228Fc409a613bDbD8eC5a97b3);
        jobId = "7d80a6386ef543a3abb52817f6707e3b";
        fee = (1 * LINK_DIVISIBILITY) / 10; // 0,1 * 10**18 (Varies by network and job)
    }

    function setFetchUrl (string memory _fetchUrl) public {
        FETCH_URL = _fetchUrl;
    }

    function requestName() public returns (bytes32 reqId) {
        Chainlink.Request memory req = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfillReqName.selector
        );
        req.add(
            "get",
            FETCH_URL
        );
        req.add("path", "0,name"); // Chainlink nodes 1.0.0 and later support this format
        // Sends the request
        return sendChainlinkRequest(req, fee);
    }
    function fulfillReqName(
        bytes32 _requestId,
        string memory _name
    ) public recordChainlinkFulfillment(_requestId) {
        emit Request(_requestId, _name);
        name = _name;
    }

    function requestImage() public returns (bytes32 reqId) {
        Chainlink.Request memory req = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfillReqImage.selector
        );
        req.add(
            "get",
            FETCH_URL
        );
        req.add("path", "0,image"); // Chainlink nodes 1.0.0 and later support this format
        // Sends the request
        return sendChainlinkRequest(req, fee);
    }
    function fulfillReqImage(
        bytes32 _requestId,
        string memory _image
    ) public recordChainlinkFulfillment(_requestId) {
        emit Request(_requestId, _image);
        image = _image;
    }
    function requestDescription() public returns (bytes32 reqId) {
        Chainlink.Request memory req = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfillReqDescription.selector
        );
        req.add(
            "get",
            FETCH_URL
        );
        req.add("path", "0,symbol"); // Chainlink nodes 1.0.0 and later support this format
        // Sends the request
        return sendChainlinkRequest(req, fee);
    }
    function fulfillReqDescription(
        bytes32 _requestId,
        string memory _description
    ) public recordChainlinkFulfillment(_requestId) {
        emit Request(_requestId, _description);
        description = _description;
    }

    function requestPrice() public returns (bytes32 reqId) {
        Chainlink.Request memory req = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfillReqPrice.selector
        );
        req.add(
            "get",
            FETCH_URL
        );
        req.add("path", "0,symbol"); // Chainlink nodes 1.0.0 and later support this format
        // Sends the request
        return sendChainlinkRequest(req, fee);
    }
    function fulfillReqPrice(
        bytes32 _requestId,
        string memory _price
    ) public recordChainlinkFulfillment(_requestId) {
        emit Request(_requestId, _price);
        description = _price;
    }

    function withdrawLink() public onlyOwner {
        LinkTokenInterface link = LinkTokenInterface(chainlinkTokenAddress());
        require(
            link.transfer(msg.sender, link.balanceOf(address(this))),
            "Unable to transfer"
        );
    }   
    function linkBalance() public view  returns(uint256){
        LinkTokenInterface link = LinkTokenInterface(chainlinkTokenAddress());
        return link.balanceOf(address(this));
    }
}