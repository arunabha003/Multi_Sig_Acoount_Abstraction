// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {MinimalAccount} from "src/ethereum/MinimalAccount.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";

contract DeployMinimal is Script {
    function run() public {
        deployMinimalAccount();
    }

    function deployMinimalAccount() public returns (HelperConfig, MinimalAccount) {
        HelperConfig helperConfig = new HelperConfig();
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();
        address[] memory AccountHoldersAddressToPass=Setting_AccountHolders();
        vm.startBroadcast(config.account);
        MinimalAccount minimalAccount = new MinimalAccount(config.entryPoint,AccountHoldersAddressToPass,3);
        minimalAccount.transferOwnership(config.account);
        vm.stopBroadcast();
        return (helperConfig, minimalAccount);
    }

function Setting_AccountHolders() internal pure returns (address[] memory ) {
    // Allocate memory for 3 addresses
    address[] memory AccountHoldersAddress = new address[](3) ;

    // Assign the addresses to the array
    AccountHoldersAddress[0] = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    AccountHoldersAddress[1] = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
    AccountHoldersAddress[2] = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;

    // Return the array
    return AccountHoldersAddress;
}

}
