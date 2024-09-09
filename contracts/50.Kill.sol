// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 合约自毁
// selfdestruct 合约自毁，把合约余额转给指定地址
// 删除合约
// 强制发送主币到其他地址

contract Kill {
    // 合约构造函数，接收主币，让合约中存储下主币
    constructor() payable {}

    function kill() external {
        // 强制发送合约的剩余主币到合约调用者地址
        selfdestruct(payable(msg.sender));
    }

    // 测试函数，测试合约是否自毁成功，成功则无法调用
    function testCall() external pure returns (uint) {
        // 无法调用
        return 123;
    }
}

// 助手合约，不存在回退函数，默认情况不能接收主币，给它发生主币会报错
contract Helper {
    // 测试是否收到主币
    function getBalance() external view returns (uint) {
        return address(this).balance; // 获取合约余额
    }

    // 助手合约调用合约自毁
    function kill(Kill _kill) external {
        _kill.kill();
    }
}
