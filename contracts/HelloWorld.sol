// SPDX-License-Identifier: MIT 
// 版权声明

pragma solidity ^0.8.7; // 声明合约文件的版本，^ 代表8.7及以上版本都可以

// 合约声明
contract HelloWorld {
    string public myString = "Hello World"; // 变量声明，可视范围 public，会自带一个只读方法
}