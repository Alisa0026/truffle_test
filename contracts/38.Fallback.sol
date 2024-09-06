// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 回退函数
// 调用函数不存在，或者直接向合约中发送以太坊主币时，都会调用回退函数
// 8.0有两种不同的写法

// fallback()和receive()函数的区别
// 以太坊主币发送到合约时，先判断 msg.data 是否为空
// 如果不为空，调用 fallback() 函数
// 如果为空，判断 receive() 函数是存在
// 如果存在，调用 receive() 函数
// 如果不存在，调用 fallback() 函数

contract Fallback {
    event Log(string msg, address indexed sender, uint value, bytes data);

    // 第一种写法：可以接收主币和data
    // 回退函数，可以接收主币的发送，调用不存在的合约的函数就会被调用
    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data); // msg.value 调用合约发送的主币数量
    }

    // 第二种写法：只接受主币的写法，receive函数必须加payable
    receive() external payable {
        emit Log("receive", msg.sender, msg.value, ""); // receive函数不能接收data
    }
}
