const { ethers } = require('ethers');


const Provider = new ethers.getDefaultProvider('https://mainnet.infura.io/v3/6a151e4cf3b6461f8ce6ac3d467df4ff');

const address1 = '0x8E4275cfE5Fa615db56bDEcFcdDD1a6268F3e4E7'; // mine
const address2 = '0xdafea492d9c6733ae3d56b7ed1adb60692c98bc5'; // random
const ERC_20_ABI = [
    "function name() view returns (string)",
    "function symbol() view returns (string)",
    "function totalSupply() view returns (uint256)",
    "function balanceOf(address) view returns (uint)"
]
const Caddress = '0x514910771AF9Ca656af840dff83E8264EcF986CA';
const contract = new ethers.Contract(Caddress, ERC_20_ABI, Provider);

const main = async () => {
    const name = await contract.name().then(console.log);
    const symbol = await contract.symbol().then(console.log);
    const totalSupply = await contract.totalSupply().then(data => console.log(ethers.formatEther(data)));
    const balanceOf = await contract.balanceOf('0xdafea492d9c6733ae3d56b7ed1adb60692c98bc5').then(console.log);

}

main();