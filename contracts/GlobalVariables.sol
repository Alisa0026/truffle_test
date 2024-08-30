// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 全局变量，不用定义就显示内容的变量。记录链上的信息和账户信息
contract GlobalVariables {
    // view 只读方法，会读取一些变量的值，pure不能读取全局、状态变量
    function globalVars() external view returns(address, uint, uint) { // 返回值类型，返回值
        address sender = msg.sender; // 调用者的地址,指的上一个调用的地址，可能是一个人也可能是上一个调用这个合约的另一个合约
        uint timestamp = block.timestamp; // 当前区块的时间戳
        uint blockNumber = block.number; // 当前区块的编号

        return (sender, timestamp, blockNumber);
    }
}
