// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 映射 Mapping 迭代
// 把数组和mapping结合，实现迭代
contract MappingIterable {
    // 声明映射，地址对应uint这个类型是记账式类型，针对某个地址，记录账本余额
    mapping(address => uint) public balances; // 查找某个地址的余额
    mapping(address=>bool) public inserterd;  // 地址对应是否存在的映射
    address[] public keys; // 存储所有存在的地址

    // 设置，地址、余额
    function set(address _key,uint _value) external{
        balances[_key] = _value;
        // 如果不存在，就添加到keys数组
        if(!inserterd[_key]){
            inserterd[_key] = true;
            keys.push(_key); // 在数组中可以遍历出所有地址
        }
    }
    // 获取所有地址长度
    function getSize() external view returns(uint){
        return keys.length;
    }
    // 获取第一个地址的余额
    function first() external view returns(uint){
        return balances[keys[0]];
    }
    // 获取最后一个地址的余额
    function last() external view returns(uint){
        return balances[keys[keys.length-1]];
    }
    // 获取任意一个索引的余额
    function get(uint _i)external view returns(uint){
        return balances[keys[_i]];
    }
}
