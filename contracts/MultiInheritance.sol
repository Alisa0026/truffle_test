// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 多线继承--基类到派生的关系,继承最少的放前面

/*
Z继承X、Y：X 要写前面，Y写后面
    X
   /| 
  Y | 
   \|
    Z 


// order of most base like to derived
// X, Y, Z
// Z继承B，B继承A，A继承X，同时Z还要继承Y，Y也继承X
// X 最基础，Y,A, B在后面，Z在最后
    X
   / \
  Y   A
  |   |
  |   B
   \ /
    Z

*/
contract X {
    function foo() public pure virtual returns (string memory) {
        return "X";
    }

    function bar() public pure virtual returns (string memory) {
        return "X";
    }

    function x() public pure returns (string memory) {
        return "X";
    }
}

contract Y is X {
    function foo() public pure virtual override returns (string memory) {
        return "Y";
    }

    function bar() public pure virtual override returns (string memory) {
        return "Y";
    }

    function y() public pure returns (string memory) {
        return "Y";
    }
}

contract Z is X, Y {
    // override(X,Y) 同时覆盖两个合约的函数
    function foo() public pure virtual override(X, Y) returns (string memory) {
        return "Z";
    }

    function bar() public pure virtual override(X, Y) returns (string memory) {
        return "Z";
    }
}
