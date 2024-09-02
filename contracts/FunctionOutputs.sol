// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 函数的输出
// Return multiple outputs 函数在智能合约中有多个输出
// Named outputs
// Destructuring Assignment 解构赋值

contract FunctionOutputs {
    // public 公开可视，内部外部都可以调用。合约中其他函数还可以调用它
    function returnMany() public pure returns (uint, bool) {
        return (1, true);
    }

    // 给返回值加名字
    function named() public pure returns (uint x, bool b) {
        return (1, true);
    }

    // 隐式返回
    function assigned() public pure returns (uint x, bool b) {
        x = 1;
        b = true;
    }

    // 合约中如何调用到返回值,解构赋值
    function destructingAssigment() public pure {
        (uint x, bool b) = returnMany();

        // 如果只要用b，可以把x删掉，但是要保留逗号
        (, bool _b) = returnMany();
    }
}
