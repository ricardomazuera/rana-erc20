// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {DeployRanaToken} from "script/DeployRanaToken.s.sol";
import {RanaToken} from "src/RanaToken.sol";

contract RanaTokenTest is Test {
    RanaToken public ranaToken;
    DeployRanaToken public deployer;

    address bob;
    address alice;

    uint256 STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployRanaToken();
        ranaToken = deployer.run();

        bob = (makeAddr("bob"));
        alice = (makeAddr("alice"));

        vm.prank(msg.sender);
        ranaToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {
        assertEq(STARTING_BALANCE, ranaToken.balanceOf(bob));
    }

    function testAllowances() public {
        uint256 initialAllowance = 1000;

        // Bob approves Alice to spend 1000 RANA on his behalf
        vm.prank(bob);
        ranaToken.approve(alice, initialAllowance);

        uint256 transferAmount = 500;

        vm.prank(alice);
        ranaToken.transferFrom(bob, alice, transferAmount);

        assertEq(transferAmount, ranaToken.balanceOf(alice));
        assertEq(STARTING_BALANCE - transferAmount, ranaToken.balanceOf(bob));
    }
}
