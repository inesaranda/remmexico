# remmexico

Open the file Thether (1).sol 
run it in REMIX 
Deploy a contract with the environment Remix VM (Merge)
Choose two addresses in the account, one as the sender and another one as the receiver

In the contract:
1: SetInitialBalance: copy the address of the sender and add the amount of desired money to put in the platform
2: SendRemmittance: copy the address of the sender under "sender" and the address of the receiver under "recipient" and add the desired value to send in US dollars (note that the transaction fee of 1% will be substracted from the sender, so if it has 1000 available USD, only 990 USD will be available to be sent)
3: Check the balances: BalancesMXN to check the balance of the recipient in Mexican Pesos, and BalancesUSD to check the balance of the sender in US Dollars. 
