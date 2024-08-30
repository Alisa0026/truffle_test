// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 计数器合约，对一个状态变量进行增减操作
contract Counter {
    uint public count; // 公开（内部外部都可读取）可视的状态变量

    // 增加，外部可视，写入方法，不能有view、pure关键词
    function inc() external {
        count += 1;
    }

    // 减少，外部可视，在合约内部其他函数不能调用的。
    function dec() external {
        count -= 1;
    }
}
