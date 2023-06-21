// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
// import library of smart contracts in ethereum from openzeppelin
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// the contract will consist of the token Tether, an exchange from us dollaars to mexican pesos and a transaction fee
contract Remmexico {
    IERC20 private tether;
    uint private exchangeRate;
    uint private transactionFee;

    mapping(address => uint) public balancesUSD;  // Mapping to store balances in US Dollars
    mapping(address => uint) public balancesMXN;  // Mapping to store balances in Mexican pesos 

    event Transaction(address indexed sender, address indexed recipient, uint amount, string currency);

    constructor() {
        tether = IERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7); // Tether address
        exchangeRate = 18; // One Tether = 18 Mexican Pesos (approx.)
        transactionFee = 1; // 1% transaction fee
    }

    function sendRemittance(address sender, address recipient, uint amountUSD) external {
        uint feeAmount = (amountUSD * transactionFee) / 100;
        uint amountMXN = (amountUSD) * exchangeRate;

        // Transfer the tokens from the sender to the exchange address (simulation environment handles this)

        balancesUSD[sender] -= (amountUSD + feeAmount);  // Deduct the sent amount in USD plus the fee from the sender's balance
        balancesMXN[recipient] += amountMXN;  // Add the received amount in MXN to the recipient's balance

        emit Transaction(sender, recipient, amountMXN, "MXN");
    }
    // create function to set for an initial balance to the sender
    function setInitialBalance(address account, uint amountUSD) external {
        balancesUSD[account] = amountUSD;
    }
    // function to retrieve the balance of the sender 
    function getBalanceUSD(address account) public view returns (uint) {
        return balancesUSD[account];
    }
    // function to retrieve the balance of the receiver 
    function getBalanceMXN(address account) public view returns (uint) {
        return balancesMXN[account];
    }
}
