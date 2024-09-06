// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 发送ETH有3种方式
// transfer--2300gas，失败reverts
// send--2300gas，returns bool
// call--all gas，returns bool and data 发送所有剩余的gas，返回bool和data

contract SendEth {
    // 存入主币
    constructor() payable {}

    receive() external payable {}

    // 通过transfer发送ETH，gas2300，gas消耗完或者发生异常，失败revert
    function sendViaTransfer(address payable _to) external payable {
        // transfer方法，发送失败会revert
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) external payable {
        // send方法，发送失败返回false
        bool sent = _to.send(123);
        require(sent, "send failed");
    }

    function sendViaCall(address payable _to) external payable {
        // call方法，发送失败返回false
        (bool success, bytes memory data) = _to.call{value: 123}("");
        require(success, "call failed");
    }
}

// 接收主币发送的目标地址
contract EthReceiver {
    event Log(uint amount,uint gas);

    // 存入主币
    receive() external payable {
        emit Log(msg.value, gasleft()); // gasleft()返回剩余的gas
    }
}
