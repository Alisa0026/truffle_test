// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 只读函数
contract ViewAndPureFunctions {
    uint public num;

    // view 读取num状态变量，读链上的信息要用view
    function viewFunc() external view returns (uint) {
        return num;
    }
    // pure 不会读链上信息，只读局部变量
    function pureFunc() external pure returns (uint) {
        return 1;
    }

    // 因为读了状态变量要用view
    function addToNum(uint x) external view returns (uint){
        return num+x
    }
    // 两个参数进行相加，不会读取状态变量，是一个纯函数，用pure
     function add(uint x,uint y) external pure returns (uint){
        return x+y
    }
}
