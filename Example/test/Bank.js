const { expect } = require('chai');
const { ethers } = require('hardhat');
const assert = require('chai').assert;


describe('Bank', () => {
    var bank;
    //  Runs this before executing all the describe/it functions.
    beforeEach(async () => {
        const Bank = await ethers.getContractFactory('Bank');
        bank = await Bank.deploy(22);
    })

    describe('deployment', () => {
        it('deposits the initial amount', async () => {
            const balance = await bank.balance();
            expect(balance).to.equal(22);
        });
    })

    describe('bank is working', () => {
        var transaction;
        it('deposits the amount', async () => {
            transaction = await bank.deposit(123);
            await transaction.wait();
            let balance = await bank.balance();
            expect(balance).to.equal(145);
        })

        it('withdraws the amount', async () => {
            transaction = await bank.withdraw(123);
            await transaction.wait();
            let balance = await bank.balance();
            expect(balance).to.equal(22);
        })

        it('provides the loan amount', async () => {
            transaction = await bank.getLoan(111);
            await transaction.wait();
            let balance = await bank.balance();
            let loan = await bank.loan();
            expect(balance).to.equal(133);
            expect(loan).to.equal(111);
        })

        it('reverts the transaction', async () => {
            transaction = await bank.withdraw('123');
            await transaction.wait();
            expect(transaction).to.be.reverted;
        })

        // Checks if the function is returning prper results.
        it("checks for function's return value", async () => {

            // Try to withdraw an amount greater than the account balance
            const result = await bank.ret_str();
            
            // Check that the function returns the expected error message
            assert.equal(result, "value", "something went wrong");
        });

        it('Retrives correct data', async()=>{
            const result = await bank.getBalance();

            const balance = await bank.balance();
            expect(balance).to.equal(result);
        })
    })
});
