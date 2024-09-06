// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 可视范围
// private(私有)、合约内部可见
// internal(内部)、合约内部和被继承的子合约内
// external(外部)、仅在外部可见，内部不可见
// public(公开) 内部、被继承的、外部都可见

/*

 _________________
| A               |
| private pri()   |
| internal inter()| 
| external ext()  | <----------- C
| public pub()    |   pub() and ext()
|_________________|
| B is A          |
| inter()         | <----------- C
| pub()           |   pub() and ext()
|_________________| 

*/

contract VisibilityBase {
    uint private x = 0;
    uint internal y = 0;
    uint public z = 0;

    // private
    function privateFunc() private pure returns (uint) {
        return 0;
    }

    // internal
    function internalFunc() internal pure returns (uint) {
        return 100;
    }

    // public
    function publicFunc() public pure returns (uint) {
        return 200;
    }

    // external
    function externalFunc() external pure returns (uint) {
        return 300;
    }

    function example() external view {
        // 可以看到哪些变量和函数
        x + y + z;
        privateFunc();
        internalFunc();
        publicFunc();
        // externalFunc(); // 外部函数这里访问不到
         // 这样可以访问外部函数，this就是先到合约外部，再回到合约里面，会浪费gas，不建议这样使用
        this.externalFunc();
    }
}

contract VisibilityChild is VisibilityBase {
    function example2() external view {
        // 可以看到哪些变量和函数
        // x 访问不到
        y + z;
        internalFunc();
        publicFunc();
        // privateFunc();
        // externalFunc();
    }
}