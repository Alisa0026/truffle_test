// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 常量 373 gas
contract Constants {
    // 管理员地址、特殊编码定义成常量，可以节省gas。constant就是常量
    address public constant MY_ADDRESS = 0x1234567890123456789012345678901234567891; 
    uint public constant MY_UINT = 123;
}

// 普通状态变量 2483 gas
contract Var {
    // 没加 constant 
    address public MY_ADDRESS = 0x1234567890123456789012345678901234567891; 
}

// 写入函数读取常量的时候，要按照是否定义常量消耗gas
