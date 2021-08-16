# yieldly-tech-demo

!!!THIS IS NOT PRODUCTION CODE, NO SECURITY MEASURES HAVE BEEN ADDED, USE AT YOUR OWN RISK!!!

Demo code showcasing the basic functionality of Yieldlys staking and prize-game pools.

* [Algorand Developer Office Hours](https://www.youtube.com/watch?v=uPjHarsK3DU&t=2089s&ab_channel=Algorand)
* [Link to presentation](https://docs.google.com/presentation/d/1M4XVdl2DdJX1EK5M1vP775Swg2Ij3HxzJg9c8H-waRQ/edit)

## Files

### TEAL
Located in the /contracts folder.

* demo: All stateful logic is held in this contract 
* close: Clear-out logic
* escrow: Stateless contract logic for holding the applications assets

### Scripts
CD into the /script folder and run:

```
./script_name.sh
```

* create_app: Creates your application
* optin: Opts your escrow into your asset
* lock: Locks your reward tokens into the pool
* unlock: Unlocks the rewards you have locked in the pool
* stake: Stakes your assets into the contract
* withdraw: Withdraws your assets into the contract
* claim: Claims any rewards you have accumilated in the pool

### Prerequisites
* Install a local testnet node: https://developer.algorand.org/docs/run-a-node/setup/install/ 
* Create your Asset using the following method: https://developer.algorand.org/docs/features/asa/
* Fill in all your scripts with the relevant account, application and asset information