// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 事件：记录当前合约运行状态的方法，不记录在状态变量中，体现在区块链浏览器上

contract Event {
    // 定义事件：事件报告的数据类型
    event Log(string message, uint val);
    // indexed 标记过的变量可以在链外进行搜索查询，有索引的变量最多只能有3个
    event IndexedLog(address indexed sender, uint val);

    // 这个函数没有读取写入状态变量，但是是写入方法，不能标记pure、view
    function example() external {
        // 触发事件
        emit Log("foo", 123);

        // 可以指定某用户的地址，查询所有他上报的事件
        emit IndexedLog(msg.sender, 789);
    }

    // 消息事件，事件存储更解压gas
    event Message(address indexed _from, address indexed _to, string message);

    // 消息发送者就是当前合约的调用者，传参只要接受者地址就可以。
    function sendMessage(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }
}
