// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "forge-std/Test.sol";
import "../src/EbrCoin.sol";

contract EbrCoinTest is Test {
    EbrCoin token;
    address alice;
    address bob;

    function setUp() public {
        token = new EbrCoin(1000);
        alice = address(0x1);
        bob = address(0x2);
    }

    function testInitialBalanceUsingDeployer() public {
        assertEq(token.balanceOf(address(this)), 1000);
    }

    function testTransfer() public {
        token.transfer(alice, 100);
        assertEq(token.balanceOf(alice), 100);
    }

    function testFailTransferNotEnoughBalance() public {
        token.transfer(alice, 2000);
    }

    function testApproveAndTransferFrom() public {
        token.approve(alice, 100);
        token.transferFrom(address(this), bob, 100);
        assertEq(token.balanceOf(bob), 100);
    }

    function testFailTransferFromNotApproved() public {
        token.transferFrom(address(this), bob, 100);
    }

    function testPauseAndUnpause() public {
        token.pause();
        assertTrue(token.paused());
        token.unpause();
        assertFalse(token.paused());
    }

    function testFailTransferWhenPaused() public {
        token.pause();
        token.transfer(alice, 100);
    }

    function testFailUnpauseNotOwner() public {
        vm.prank(bob);
        token.unpause();
    }

    function testOwnershipTransfer() public {
        token.transferOwnership(bob);
        assertEq(token.owner(), bob);
    }

    function testFailOwnershipTransferNotOwner() public {
        vm.prank(alice);
        token.transferOwnership(bob);
    }
}
