// SPDX-License-Identifier: MIT
// 版权声明

pragma solidity ^0.8.7; // 声明合约文件的版本，^ 代表8.7及以上版本都可以

// 构造函数，仅能在合约部署的时候调用一次。一般用于初始化一些变量
contract Constructor {
    address public owner;
    uint public x;

    constructor(uint _x) {
        owner = msg.sender; // 当前合约部署者的地址
        x = _x; // 输入x赋值给状态变量中
    }
}
