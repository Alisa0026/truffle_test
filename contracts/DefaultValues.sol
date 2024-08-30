// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 变量默认值
// 所有状态变量、局部变量在没有赋值之前都有默认值
contract DefaultValues {
    bool public b; // 默认值 false
    uint public u; // 默认值 0
    int public i; // 默认值 0
    address public a; // 默认值 0地址，40个0，20位16进制数字。0x0000000000000000000000000000000000000000
    bytes32 public b32; // 默认值 32位16进制数字，64个0。 0x0000000000000000000000000000000000000000000000000000000000000000
    // 后面会提到 mapping,structs,enums.fixed sized arrays 的默认值是多少
}