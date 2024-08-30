// SPDX-License-Identifier: MIT
// 版权声明

pragma solidity ^0.8.7; // 声明合约文件的版本，^ 代表8.7及以上版本都可以

// 函数修改器，使复用代码简化的语法。
// Basic 基本类型，inputs 可以输入参数的，sandwich 三明治式的
contract FunctionModifier {
    bool public paused;
    uint public count;

    // 修改器函数
    function setPause(bool _paused) external {
        paused = _paused;
    }

    // 修改器函数
    modifier whenNotPaused() {
        require(!paused, "paused");
        _; // 代表函数其他代码在哪里运行
    }

    // function inc() external {
    //     // 确认当前合约是否暂停，暂停则抛出异常,都有的重复代码可以拿出来作为函数修改器的内容
    //     require(!paused, "paused");
    //     count += 1;
    // }
    // function dec() external {
    //     // 确认当前合约是否暂停，暂停则抛出异常
    //     require(!paused, "paused");
    //     count -= 1;
    // }

    // 函数后面加上函数修改器，可以简化代码，运行会先进入修改器，运行到 _; 之后再运行函数其他代码
    function inc() external whenNotPaused {
        count += 1;
    }

    function dec() external whenNotPaused {
        count -= 1;
    }

    // --------------带参数的修改器 --------------
    modifier cap(uint _x) {
        require(_x < 100, "x >=100");
        _;
    }
    //  _x 每次都要检查是否小于100
    function incBy(uint _x) external whenNotPaused cap(_x) {
        count += _x;
    }

    // --------------三明治的修改器 --------------
    modifier sandwich() {
        // code here
        count += 10;
        _;
        // more code here
        count *= 2;
    }
    // 先进入修改器，运行+=10，然后运行函数代码，再进入修改器，运行*=2
    function foo() external sandwich {
        count += _x;
    }
}
