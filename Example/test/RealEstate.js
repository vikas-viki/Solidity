const { expect } = require('chai');
const { ethers } = require('hardhat');
const assert = require('chai').assert;
// Returns formatted ether from wei.
const token = (n) => {
    return ethers.utils.parseUnits(n.toString(), 'ether');
}
ether = token;

describe('Real estate', () => {
    let realEstate, escrow;
    let deployer, seller, buyer;
    let nftID = 1;
    let purchasePrice = ether(100);
    let escrowAmt = ether(20);
    beforeEach(async () => {

        // Setup accounts.
        accounts = await ethers.getSigners();
        deployer = accounts[0];
        buyer = accounts[1];
        seller = deployer;
        lender = accounts[2];
        inspector = accounts[3];


        // Load contracts.
        const RealEstate = await ethers.getContractFactory('RealEstate');
        const Escrow = await ethers.getContractFactory('Escrow');

        // Deploy
        realEstate = await RealEstate.deploy();
        escrow = await Escrow.deploy(
            realEstate.address,
            nftID,
            seller.address,
            buyer.address,
            lender.address,
            inspector.address,
            purchasePrice,
            escrowAmt
        );

        // Seller approves the transaction
        transaction = await realEstate.connect(seller).approve(escrow.address, nftID);
        await transaction.wait();

    })

    // Checks if the contract is deployed successfully.
    describe('Deployment', async () => {
        it('sends an NFT to seller/deployer', async () => {
            expect(await realEstate.ownerOf(nftID)).to.equal(seller.address);
        })
    })

    describe('Selling RealEstate', async () => {
        let transaction, balance;
        it('Executes successful transaction', async () => {
            // expect selle to be owner before the sale.
            expect(await realEstate.ownerOf(nftID)).to.equal(seller.address);

            // balance before buyer deposits
            balance = await escrow.getBalance();
            console.log("balance before buyer deposits: ", ether(balance));

            // Buyer deposits earnest
            transaction = await escrow.connect(buyer).depositEarnest({ value: ether(20) });
            await transaction.wait();
            console.log("Buyer deposits amount");

            // balance after buyer deposits
            balance = await escrow.getBalance();
            console.log("balance after buyer deposits: ", ether(balance));

            // inspector updates status.
            transaction = await escrow.connect(inspector).updateInspectionStatus(true);
            await transaction.wait();
            console.log('Inspector updates status');

            // buyer approves sale.
            transaction = await escrow.connect(buyer).approveSale();
            await transaction.wait();
            console.log('Buyer approves buying');

            // seller approves sale.
            transaction = await escrow.connect(seller).approveSale();
            await transaction.wait();
            console.log('Seller approves selling');

            // Lender funds for the sale behalf of buyer.
            transaction = await lender.sendTransaction({ to: escrow.address, value: ether(80) });
            console.log("Lender funds for the sale behalf of buyer.");

            // balance after lender deposits
            balance = await escrow.getBalance();
            console.log("balance after lender deposits: ", ether(balance));

            // ledner approves sale.
            transaction = await escrow.connect(lender).approveSale();
            await transaction.wait();
            console.log('lender approves sale');

            // final balance before sale.
            balance = await escrow.getBalance();
            console.log("final balance before sale: ", ether(balance));

            // Finalize sale.
            transaction = await escrow.connect(buyer).finalizeSale();
            await transaction.wait();
            console.log("Land sold successfully");

            // Checks escrow amount.
            balance = await escrow.getBalance();
            console.log("balance of escrow after sale: ", ether(balance));

            // Expect buyer to be the owner of NFT after sale.
            expect(await realEstate.ownerOf(nftID)).to.equal(buyer.address);
            console.log("buyer gets his land");

            // check if the seller got his amount.
            balance = await ethers.provider.getBalance(seller.address);
            console.log("Balance of seller after successful sale:", ethers.utils.formatEther(balance));
            expect(balance).to.be.above(ether(1099));

        })
    })

})