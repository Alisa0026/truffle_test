// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 如何调用父级合约的函数

/*
calling parent functions
    direct
    super

    E
   / \
  F   G
   \ /
    H

*/
contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() public virtual override {
        emit Log("F .foo");
        // 直接调用父级合约
        E.foo();
    }

    function bar() public virtual override {
        emit Log("F .bar");
        // super调用父级合约
        super.bar();
    }
}

contract G is E {
    function foo() public virtual override {
        emit Log("G .foo");
        E.foo();
    }

    function bar() public virtual override {
        emit Log("G .bar");
        super.bar();
    }
}

contract H is F, G {
    function foo() public virtual override(F, G) {
        // 直接调用父级合约,运行执行
        // 1. F.foo
        // 2. E.foo
        F.foo();
    }

    function bar() public virtual override(F, G) {
        // super自己找父级合约，F，G两个合约都会被执行。
        // 1. F.bar
        // 2. G.bar
        // 3. E.bar 虽然F和G中都写了super调用E的，但是E.bar会被调用一次
        super.bar();
    }
}
