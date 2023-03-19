// Connect to the Ethereum network using Ethers.js
const provider = new ethers.providers.Web3Provider(window.ethereum);
console.log(provider)
// Create an instance of the contract using its address and ABI
const contractAddress = "0xd9145CCE52D386f254917e481eB44e9943F39138";
const contractABI = [
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "_amt",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "_years",
                "type": "uint256"
            }
        ],
        "name": "createFD",
        "outputs": [
            {
                "internalType": "string",
                "name": "",
                "type": "string"
            }
        ],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "_amt",
                "type": "uint256"
            }
        ],
        "name": "deposit",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "_amt",
                "type": "uint256"
            }
        ],
        "name": "getLoan",
        "outputs": [
            {
                "internalType": "string",
                "name": "",
                "type": "string"
            }
        ],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "stateMutability": "nonpayable",
        "type": "constructor"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "_amt",
                "type": "uint256"
            }
        ],
        "name": "withdraw",
        "outputs": [
            {
                "internalType": "string",
                "name": "",
                "type": "string"
            }
        ],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "balance",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "fdAmount",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "fdIntrest",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "fdYears",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getBalance",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "intrest",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "loan",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "user",
        "outputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    }
];
const contract = new ethers.Contract(contractAddress, contractABI, provider);

// Update the UI with the current balance and loan
async function updateUI() {
    const balance = await contract.getBalance();
    const loan = await contract.loan();
    document.getElementById("balance").textContent = balance.toString();
    document.getElementById("loan").textContent = loan.toString();
}

// Deposit funds into the contract
async function deposit() {
    const depositAmount = document.getElementById("depositAmount").value;
    const tx = await contract.deposit(depositAmount);
    await tx.wait();
    await updateUI();
}

// Withdraw funds from the contract
async function withdraw() {
    const withdrawAmount = document.getElementById("withdrawAmount").value;
    const tx = await contract.withdraw(withdrawAmount);
    await tx.wait();
    await updateUI();
}

// Get a loan from the contract
async function getLoan() {
    const loanAmount = document.getElementById("loanAmount").value;
    const tx = await contract.getLoan(loanAmount);
    await tx.wait();
    await updateUI();
}

// Create a fixed deposit with the contract
async function createFD() {
    const fdAmount = document.getElementById("fdAmount").value;
    const fdYears = document.getElementById("fdYears").value;
    const tx = await contract.createFD(fdAmount, fdYears);
    await tx.wait();
    await updateUI();
}

// Call updateUI once at the beginning to populate the initial values
updateUI();
