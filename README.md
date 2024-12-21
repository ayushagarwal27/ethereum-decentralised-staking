# 🔏 Decentralized Staking App

A decentralized application where users can coordinate a group funding effort. If the users cooperate, the money is collected in a second smart contract. If they defect, everyone gets their money back. 

🏦 A `Staker.sol` contract that collects **ETH** from numerous addresses using a payable `stake()` function and keeps track of `balances`. After some `deadline` if it has at least some `threshold` of ETH, it sends it to an `ExampleExternalContract` and triggers the `complete()` action sending the full balance. If not enough **ETH** is collected, allow users to `withdraw()`.

🎛 A frontend that allow anyone to stake using your app. Use of `Stake(address,uint256)` event to list all stakes.