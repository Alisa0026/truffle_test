// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 通过合约调用其他合约

// 调用合约去调用测试合约的函数
contract CallOtherContracts {
    // 把类型直接当做输入变量传入
    // function setX(TestContracts _test, uint _x) external {
    //     // 另一个合约的类型TestContracts，传入地址_test，就可以调用这个合约中的函数了
    //    _test.setX(_x); // 调用测试合约的setX函数
    // }
    function setX(address _test, uint _x) external {
        // 另一个合约的类型TestContracts，传入地址_test，就可以调用这个合约中的函数了
        TestContracts(_test).setX(_x); // 调用测试合约的setX函数
    }

    // function getX(address _test) external view returns (uint) {
    //     return TestContracts(_test).getX();
    // }
    // 或者直接定义x，让x直接等于返回值
    function getX(address _test) external view returns (uint x) {
        x = TestContracts(_test).getX();
    }

    // 设置变量的时候还要传入主币
    function setXandReceiveEther(address _test, uint _x) external payable {
        // {value: msg.value} 方式传递主币
        TestContracts(_test).setXandReceiveEther{value: msg.value}(_x);
    }

    // function getXandValue(
    //     address _test
    // ) external view returns (uint, uint) {
    //     (uint x, uint value) =  TestContracts(_test).getXandValue();
    //     return (x, value);
    // }
    // 或者下面这样写
    function getXandValue(
        address _test
    ) external view returns (uint x, uint value) {
        (x, value) = TestContracts(_test).getXandValue();
    }
}

contract TestContracts {
    uint public x;
    uint public value = 123;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns (uint) {
        return x;
    }

    function setXandReceiveEther(uint _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint, uint) {
        return (x, value);
    }
}
