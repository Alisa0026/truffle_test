// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 存储位置：storage(存状态变量)、memory(存局部变量)、calldata(和memory类似，只能用在输入的参数中)

contract DataLocations {
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    function examples(
        uint[] calldata y,
        string calldata s
    ) external returns (uint[] memory) {
        myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"});

        // 读取出来，使用了storage存储位置，状态变量读取到了myStruct变量中。可以进行读取写入操作
        MyStruct storage myStruct = myStructs[msg.sender];
        myStruct.text = "foo"; // 状态变量会被改变

        // 定义内存位置，可以修改变量值，但是在函数调用结束后就消失了，不会记录到链上
        MyStruct memory readOnly = MyStruct({foo: 789, text: "baz"});
        readOnly.foo = 456;

        // 在函数的输入参数中，采用数组这样的类型，就必须要定义内存或calldata的存储类型
        uint[] memory memArr = new uint[](3);
        memArr[0] = 234;
        return memArr;

        // 如果都是calldata，可以直接传
        _internal(y);
    }

    function _internal(uint[] calldata y) private {
        uint x = y[0];
    }
}
