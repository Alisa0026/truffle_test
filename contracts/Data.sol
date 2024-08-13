// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.7; 

// 类型数值 Data types - values and references

contract ValueTypes{
    bool public b = true; // 布尔值
    uint public u = 123; // 无符号整数（正整数）unit = unit256 0 to 2**256 -1
                         //                         unit8 0 to 2**8 -1
                         //                         unit16 0 to 2**16 -1

    int public i = -123; // 有符号整数 int = int256 -2**255 to 2**255 -1
                         //                 int128 -2**127 to 2**127 -1
    int public minInt = type(int).min; // int 的最小值
    int public maxInt = type(int).max; // int 的最大值

    address public addr = 0x742d35Cc6634C0532925a3b844Bc454e4438f44e; // 地址
    bytes32 public b32 = 0x78bbbec96c5bc30ed379cb4c7bc96af4af5c71a2ed6cbd7b202097223e055294; // 32 字节的固定长度字节数组
}