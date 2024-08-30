// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.7; 

contract LocalVariable{
    uint public i;
    bool public b;
    address public myAddress;

    function foo() external{
        // 下面2个是局部变量，只在函数内部生效，不会写到区块链上
        uint x = 123;
        bool f = false;

        x+=456;
        f= true;

        // 针对状态变量进行修改，状态就会改变，链上结果发生了变化
        i=123;
        b=true;
        myAddress = address(1);
    }
}