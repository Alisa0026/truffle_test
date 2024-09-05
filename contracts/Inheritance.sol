// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 继承
// virtual 关键词表示可以被重写
contract A {
    function foo() public pure  virtual returns (string memory) {
        return "A";
    }

    function bar() public pure virtual returns (string memory) {
        return "A";
    }
    // more

    function baz() public pure returns (string memory) {
        return "A";
    }

}

// 希望B可以使用A的一部分功能
// override 覆盖父类的方法
contract B is A {
    // 重写
    function foo() public pure override returns (string memory) {
        return "B";
    }
    // 要被重写也要加上 virtual
    function bar() public pure override virtual returns (string memory) {
        return "B";
    }
    // more

    // baz 会被b继承
}

// C 继承 B(也继承了A)
contract C is B {
  
    function bar() public pure override returns (string memory) {
        return "C";
    }
}