// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 2 ways to call parent constructors
// order of initialization

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// U继承S、T，怎么输入构造函数的参数
// 已知内容 contract U is S("s"),T("t")
contract U is S("s"), T("t") {}

contract V is S, T {
    // 把参数传给父类
    constructor(string memory _name, string memory _text) S(_name) T(_text) {}
}
// 混合使用
contract VV is S("s"), T {
    constructor(string memory _text) T(_text) {}
}

// 两个合约按照继承循序初始化，构造函数后面把顺序修改了也不影响
// 1. S
// 2. T
// 3.V0 
contract V0 is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {}
}
// 合约初始化顺序
// 1. S
// 2. T
// 3.V1 
contract V1 is S, T {
    constructor(string memory _name, string memory _text) T(_name) S(_text) {}
}
// 1. T
// 2. S
// 3. V2 
contract V2 is  T,S {
    constructor(string memory _name, string memory _text) T(_name) S(_text) {}
}