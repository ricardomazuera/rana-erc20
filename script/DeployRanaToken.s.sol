// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {RanaToken} from "src/RanaToken.sol";

contract DeployRanaToken is Script {
    uint256 public INITIAL_SUPPLY = 1000 ether;

    function run() external returns (RanaToken) {
        vm.startBroadcast();
        RanaToken rt = new RanaToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return rt;
    }
}
