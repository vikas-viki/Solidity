const { ethers } = require('ethers');
// https://mainnet.infura.io/v3/6a151e4cf3b6461f8ce6ac3d467df4ff


const Provider = new ethers.getDefaultProvider('https://mainnet.infura.io/v3/6a151e4cf3b6461f8ce6ac3d467df4ff'); // Eth main net.
const Provider1 = new ethers.getDefaultProvider('https://goerli.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161'); // Goerli testnet

const Goerli1 = '0x8E4275cfE5Fa615db56bDEcFcdDD1a6268F3e4E7'; // mine test Goerli 1 acc
const Goerli2 = '0xe6d2212bAe4497902d8679294ccE974d8db8E53C'; // mine test Goerli 2 acc

const address2 = '0xdafea492d9c6733ae3d56b7ed1adb60692c98bc5'; // random
const privateKey = '5f270b7a98fccd3091035f0a7b2e474236baa91ffba7ef21adc5bca74f21e2e4'; // privateKey - you must need private key to sign transactons

const wallet = new ethers.Wallet(privateKey, Provider1);
    
// Checking balance of an account.
const balance = async () => {
    const balance = await Provider1.getBalance(Goerli1).then(data =>{
        eths = ethers.formatEther(data);
        console.log(eths);
    });
    const blockNumber = await Provider.getBlockNumber();
    console.log(blockNumber);
}

// Transfering eth to someone.
const transferEth = async () =>{

    const transaction = await wallet.sendTransaction({
        to: Goerli2, // Reciever address
        value: ethers.parseEther("0.1") // amont to be sent.(0.01 eth)
    }); // We will get a transaction back.

    // wait for transaction to be mined.
    await transaction.wait();
    console.log(transaction);
}

// Transfering erc20 token.
async function transfer_erc20(){
    const tokenAddress = "0x514910771AF9Ca656af840dff83E8264EcF986CA";
    const tokenAbi = [
        // Get balance
        "function balanceOf(address) view returns(uint)"
    ];
    
    // Getting token balance.
    const TokenContract = ethers.Contract(tokenAddress, tokenAbi);
    
    // Getting token balance.
    const tokenBalance = await TokenContract.balanceOf('0xd67ad6c867cd657cc145ce01d991a5d15e2fb035');
    console.log(tokenBalance.toString())

}
transferEth();
// balance();