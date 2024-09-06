// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 不可变量

contract Immutable {
    // 在定义一些常量时，部署合约之前值是不知道的(比如部署合约的用户地址)
    // immutable 变量在部署合约时被初始化，并且不能被修改，节约gas非，还可以在合约部署时确定变量值
    // address public immutable owner = msg.sender;

    // 或者在构造函数赋值
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    uint public x;
    function foo() external {
        require(msg.sender == owner);
        x += 1;
    }
}
