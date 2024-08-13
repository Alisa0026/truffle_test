// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.7; 

// 函数

contract FunctionIntro{
    // 加法，两个参数
    // external 外部函数 只能外部读取的函数 
    // pure代表纯函数(不能读写状态变量，只有局部变量，不对链上有读写操作)
   function add(uint x,uint y) external pure returns(uint){
       return x + y;
   }

   function sub(uint x,uint y) external pure returns(uint){
       return x - y;
   }
}