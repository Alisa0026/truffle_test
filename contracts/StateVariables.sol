// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.7; 

// 状态变量：把数据写到区块链上去，如果不写修改的方法，这个变量就被永远的保存在链上了

contract StateVariables{
    uint public myUint = 123;

    function foo() external{
        // 只有调用foo才会在虚拟机的内存中产生
        uint notStateVariable = 456; // 不是状态变量，不会被保存在链上
    }
}