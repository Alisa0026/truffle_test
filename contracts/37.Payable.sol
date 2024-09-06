// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 支付ETTH

contract Payable {
    // 标记地址payable属性，这个地址可以发送以太坊主币
    address payable public owner;

    constructor(){
        owner = payable(msg.sender); // msg.sender也要具有payable属性
    }

    // payable 关键词标记接受以太坊主币的传入
    function deposit() external payable{
      
    }

    // 显示当前合约余额
    function getBalance() external view returns(uint){
        // 返回当前地址余额
        return address(this).balance;
    }
}
