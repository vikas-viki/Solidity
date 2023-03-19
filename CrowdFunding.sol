// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CrowdFunding{

    // keep track of contributers corresponding their contributed amount. mapping => kind of table corresponding to value.
    mapping(address => uint) public contributors;

    address public manager;
    uint public minimum_contribution = 62000 wei;
    uint public deadline;
    uint public raised_Amt = 0;
    uint public noOfContributors;

    modifier deadlineNotMet{
        // Check if the deadline is not passed, if passed amount will be automatically refunded.
        require(block.timestamp < deadline, "Deadline passed");
        _;
    }

    modifier onlyManager{
        // check if the message sender is manager or not.
        require(msg.sender == manager, "Only manager can request for funding.");
        _;
    }

    // Details to be required for making a funding request.
    struct Request{
        
        // Description - why making request.
        string description;

        // For whom he/she is making request.
        address payable recipient;

        // How much amount is reqiured for request to be completed and to be sent to recipient.
        uint value;

        // Check if the poll is completed
        bool completed;

        // Check the number of voters who have voted (poll = send funds to recipient [yes / no])
        uint noOfVoters;

        // Check in voters who all have contributed.
        mapping(address => bool) voters;
    }

    // To make multiple requests, may be ne for charity, other for school and so on...
    mapping(uint => Request) public requests;

    // To keep track of number of requests, as we can't directly access requests like array.length.
    uint public numRequests;

    constructor(uint _deadline){
        deadline = block.timestamp + _deadline; // timestamp will be in seconds.
        manager = msg.sender;
    }

    // Function for contributor to contribute.
    function contribute() public payable deadlineNotMet{

        // Check if the user is paying >= minimum contribution amt, if not amount will be automatically refunded
        require(msg.value >= minimum_contribution, "Minimum contribution is not met.");

        // increment the no of contributors if the msg.send is not contibuted yet.
        if(contributors[msg.sender] == 0){
            noOfContributors++;
        }

        // increment the amount contributed by the contributor.
        contributors[msg.sender] += msg.value;

        // increment the toal amount after the contributor contributes.
        raised_Amt += msg.value;
    }

    // Check the total balance of the contract.
    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    // Check if the deadline is met or not.
    function deadLineMet() public view returns(string memory){
        if(block.timestamp < deadline){
            return "Deadline not met.";
        }else {
            return "Dedline crossed, you can't contribute";
        }
    }

    // For the user to refund his money back, with certain conditions. 
    function refund() public {

        // User can refund if deadline not met.
        require(block.timestamp > deadline, "Deadline not yet met, so you can't refund now.");

        // Check if the user has contibuted.
        require(contributors[msg.sender] == 0, "You haven't contributed");

        // Check if we have the required balance to refund.
        require(address(this).balance >= contributors[msg.sender], "Sorry, amount already sent to needeies");

        // refund user if all above criteria met.
        address payable user = payable(msg.sender);
        user.transfer(contributors[msg.sender]);

        // make the contributor's funded amount to 0.
        contributors[msg.sender] = 0;
    }

    // For the manager to make a new request for funding.
    function createRequest(string memory _description, address payable _recipient, uint _value) public onlyManager {

        // Creating new variable of type "Request" from the storage as it is using mapping.
        Request storage newRequest = requests[numRequests];

        // Increment number of requests.
        numRequests++;

        // Assign value from manager to structure value.
        newRequest.description = _description;
        newRequest.recipient = _recipient;
        newRequest.value = _value;
        newRequest.completed = false;
        newRequest.noOfVoters = 0;
    }


    function voteRequest(uint _requestNo) public {

        // Check if the message sender is a contributer.
        require(contributors[msg.sender] > 0, "You must contribute first to vote.");

        // Pick the request which is requested by the user.
        Request storage currentRequest = requests[_requestNo];

        // check if the user has already voted or not.
        require(currentRequest.voters[msg.sender] == false, "You have already voted for this request.");

        // make user voted in structure.
        currentRequest.voters[msg.sender] = true;

        // invrement the number of voters.
        currentRequest.noOfVoters++;
    }

    // Send funds to requested party.
    function sendFunds(uint _reqNo) public onlyManager{

        // Keep track of balance before sending funds.
        uint256 previousBalance = address(this).balance;

        // retrive current requested party as per the request no passed by the manager.
        Request storage currentrequest = requests[_reqNo];

        // Check if we have requested amount of funds to send.
        require(raised_Amt >= currentrequest.value, "Not enough funds to send Funds to requested party.");

        // Check if the current request hadn't been completed.
        require(currentrequest.completed == false, "The request has already been funded");

        // Make sure that the contributors accept for funding to requested party by voting.
        require(currentrequest.noOfVoters > (noOfContributors / 2), "As per the votes, the funds cant be sent to requested party because of 51%.");

        // transafer the funds to requested party.
        currentrequest.recipient.transfer(currentrequest.value);

        // Check if the fund are sent.
        require(address(this).balance <= (previousBalance-currentrequest.value), "The funds have not been transfered to requested party.");
        
        // Make the current request completed, so that we can keep track of it.
        currentrequest.completed = true;
    }
}