// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external;
}

contract Escrow {
    // Address of image(land)
    address public nftAddress;
    // ID of image(land)
    uint256 public nftID;
    // Purchase amount of the value.
    uint256 public purchasePrice;
    // advance amount.
    uint256 public escrowAmount;
    address payable seller;
    address payable buyer;
    address public lender;
    // inspects if the land is correct.
    address public inspector;
    bool public inspectionPass = false;

    // Continues the execution if the modifier returns true, like a middleware 
    modifier onlyBuyer(){
        require(msg.sender == buyer, "only buyer can send amt");
        _;
    }
    // checks if the ispector has approved the inspection.
    modifier onlyInspector(){
        require(msg.sender == inspector, "only inspector can change status");
        _;
    }
    // creates a mapping with address corresponding to boolean.
    // the bool associated with address must be true else there will be a exception.
    mapping(address => bool) public approval;

    // must be there to recieve fund/money from external sendTransaction function
    receive() external payable{}
    constructor(
        address _nftAddress,
        uint256 _nftID,
        address payable _seller,
        address payable _buyer,
        address _lender,
        address _inspector,
        uint _purchaseAmt,
        uint256 _escrowAmt
    ) {
        nftAddress = _nftAddress;
        nftID = _nftID;
        seller = _seller;
        buyer = _buyer;
        lender = _lender;
        inspector = _inspector;
        escrowAmount = _escrowAmt;
        purchasePrice = _purchaseAmt;
    }

   // cancle sale and send advance money back to the buyer if inspection not passes.
   function cancelSale() public {
    if(inspectionPass ==  false){
        payable(buyer).transfer(address(this).balance);
    }
   }
    // Returns the balance of the contract
    function getBalance () public view returns(uint){
        return address(this).balance;
    }

    // Transfer ownership of the property.
    function finalizeSale() public {
        // Checks if everthing is correct and okay & all are agreed before selling.
        require(inspectionPass, "inspection must be done first");
        require(approval[buyer], "buyer not approved");
        require(approval[seller], "seller not approved");
        require(approval[lender], "lender not approved");
        require(address(this).balance == purchasePrice, "Not enough eths to get land");
        
        // sends amount to seller before sending nft/land to buyer.
        (bool success,) = payable(seller).call{value: address(this).balance}("Your land got sold");
        require(success);
        
        // sending/passing nft/land to buyer after all confirmations.
        IERC721(nftAddress).transferFrom(seller, buyer, nftID);

    }

    // Deposits the 20% earnest money.
    function depositEarnest() public payable onlyBuyer{
        require(msg.value >= escrowAmount);
    }

    // sets approved by the person who calls this.
    function approveSale() public{
        approval[msg.sender] = true;
    }

    // updates if the inspection status.
    function updateInspectionStatus(bool _passed) public onlyInspector{
        inspectionPass = _passed;
    }

}
