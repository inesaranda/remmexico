// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Remmexico {
    IERC20 private tether;
    uint private exchangeRate;
    uint private transactionFee;

    mapping(address => uint) public balancesUSD;  // Mapping to store balances in USD
    mapping(address => uint) public balancesMXN;  // Mapping to store balances in MXN

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

    function setInitialBalance(address account, uint amountUSD) external {
        balancesUSD[account] = amountUSD;
    }

    function getBalanceUSD(address account) public view returns (uint) {
        return balancesUSD[account];
    }

    function getBalanceMXN(address account) public view returns (uint) {
        return balancesMXN[account];
    }
}
