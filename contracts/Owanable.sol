// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Ownable 权限管理的合约
// 状态变量 state variables
// 全局变量 global variables
// 函数修改器 function modifiers
// 函数 function
// 错误控制 error handling
contract Owanable {
    address public owner; // 状态变量 state variables

    // 构造函数 constructor
    constructor() {
        owner = msg.sender; // 合约部署者的地址进行赋值
    }

    // 函数修改器 function modifiers
    modifier onlyOwner() {
        // 确认调用者是合约部署者，才能继续使用合约
        require(msg.sender == owner, "Not owner"); 
        _;
    }

    // 函数 function
    // owner所有权是否可以替换给别人,只有owner才能调用
    function setOwner(address _newOwner) external onlyOwner {
        // 确认传入的地址不为空
        require(_newOwner != address(0), "invalid address");
        owner = _newOwner;
    }

    function onlyOwnerCanCallThisFunc() external onlyOwner {
        // code
    }
    function anyOneCanCall() external {
        // code
    }
}
