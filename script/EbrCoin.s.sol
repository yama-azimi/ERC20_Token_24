// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "src/EbrCoin.sol";
import "forge-std/Script.sol";

contract DeployEbrCoin is Script {
    function run() public {
        vm.startBroadcast();

        // Deploy the token with an initial supply
        uint256 initialSupply = 1e18; // For example, 1 token with 18 decimals
        EbrCoin token = new EbrCoin(initialSupply);

        // Log the address of the deployed token
        console.log("EbrCoin deployed at:", address(token));

        vm.stopBroadcast();
    }
}
