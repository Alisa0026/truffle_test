// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 低级调用其他合约 call

contract TestCall {
    string public message;
    uint public x;

    event Log(string message);

    fallback() external payable {
        emit Log("fallback was called");
    }

    // 5000 gas 修改两个变量是不够的，可以把携带gas去掉。
    function foo(
        string memory _message,
        uint _x
    ) external payable returns (bool, uint) {
        message = _message;
        x = _x;
        return (true, 999);
    }
}

// 写个合约调用上面的TestCall
contract Call {
    bytes public data;

    // 合约发送了主币，这个合约本身没有主币，必须把主币同时传递进去才能发送foo
    function callFoo(address _test) external payable {
        // 地址传入就可以直接call操作，传abi编码，函数名称以字符串的形式传入。
        // uint类型要写 uint256，参数名称和存储位置都不用写。
        // 返回两个参数 bool和bytes data里放的函数foo所有的返回值
        // call后面{value: 111}可以带主币数量
        (bool success, bytes memory _data) = _test.call{value: 111, gas: 5000}(
            abi.encodeWithSignature("foo(string,uint256)", "call foo", 123)
        );
        // 确认是否成功
        require(success, "call failed");
        data = _data;
    }

    // 可以通过低级调用，调用测试合约不存在的函数，就会进入回退函数，然后触发一个log事件
    // 如果测试合约没有回退函数，调用就会出错了
    function callDoesNotExit(address _test) external {
        (bool success, ) = _test.call(abi.encodeWithSignature("doesNotExit()"));
        require(success, "call failed");
    }
}
