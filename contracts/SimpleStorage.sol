// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.7; 

// 简单存储
contract SimpleStorage{
    string public text;

    // 写入方法，传入变量定义在calldata，external外部可见
    // 输入相同参数，
    // calldata 89626 gas，节约gas
    // memory 90114 gas
    function set(string calldata _text) external {
        text = _text;
    }

    function get() external view returns(string memory){
        return text;
    }
}