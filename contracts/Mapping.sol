// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 映射 Mapping
// 数组中查找一个元素存在，要遍历数组，消耗gas
// 做映射，可以直接查找，不消耗gas
// ["alice","bob","charlie"]
// {"alice":true,"bob":true,"charlie":true}

contract Mapping {
    // 声明映射，地址对应uint这个类型是记账式类型，针对某个地址，记录账本余额
    mapping(address => uint) public balances; // 查找某个地址的余额
    // 嵌套式映射，查找两个地址是否是朋友关系
    mapping(address => mapping(address => bool)) public isFriend;

    function example()external{
        // 设置数据
        balances[msg.sender] = 123; // 调用者有123余额
        // 获取余额
        uint bal = balances[msg.sender]; // 获取调用者的余额
        // 没有定义的地址，获取值如果没有就返回是uint的默认值0
        uint bal2 = balances[address(1)]; // 0

        // 修改之前设置过得值
        balances[msg.sender] += 456; // 调用者的余额增加456 123+456=579

        // 删除
        delete balances[msg.sender]; // 删除调用者的余额,删除后返回的是默认值 0，不是真正的删除

        // 嵌套的映射
        isFriend[msg.sender][address(this)] = true; // 两个[]，第一个是调用者，第二个是当前合约的地址

    }
}
