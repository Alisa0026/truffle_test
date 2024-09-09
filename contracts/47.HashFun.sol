// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 哈希算法特点：
// 1、输入值相同，输出值一定相同
// 2、不管输入值多大，输出值是定长的，不可逆向运算
// 用到签名运算、或者获取特定id情况下
contract HashFunc {
    // bytes32 是哈希值特定格式
    function hash(
        string memory text,
        uint num,
        address addr
    ) external pure returns (bytes32) {
        // 智能合约内置函数，keccak256哈希算法
        // encode/ encodePacked 打包:encodePacked 会有一定压缩
        return keccak256(abi.encodePacked(text, num, addr));
    }

    // 不定长要存在memory位置
    function encode(
        string memory text0,
        string memory text1
    ) external pure returns (bytes memory) {
        return abi.encode(text0, text1);
    }

    // encodePacked 把2个输入参数打包不会补0，容易出现漏洞。两个参数的值是混在一起的
    // "AAAA","BBB" 和 "AAA","ABBB" 返回的值是一样的。不同的输入参数产生了相同的打包结果，运算hash值就会得到相同的hash值结果。导致hash运算的碰撞错误。
    function encodePacked(
        string memory text0,
        string memory text1
    ) external pure returns (bytes memory) {
        return abi.encodePacked(text0, text1);
    }

    // hash碰撞实验
    // 用encode，或者两个字符串参数中加个数字参数
    function collision(string memory text0, string memory text1) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text0, text1));
    }
}
