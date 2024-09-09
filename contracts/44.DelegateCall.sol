// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 委托调用

// 形成升级合约的基本范式
/**
传统调用方法：
A calls B,sends 100 wei
       B calls C,sends 50 wei

A ----> B ----> C
                msg.sender = B
                msg.value = 50
                execute code on C's state variable
                use EHT in C

委托调用：
A calls B,sends 100 wei
       B delegatecalls C :B用委托调用C
A ----> B ----> C
                msg.sender = A
                msg.value = 100
                execute code on B's state variable 委托调用C，C不能改变自己的变状态变量
                use EHT in B
 */

// 测试合约
// TestDelegateCall接收到委托调用之后，看到的 msg.sender和msg.value 都是我们自己
// 被调用合约 TestDelegateCall 的值不能被我们改变，只能使用被调用合约 TestDelegateCall 的逻辑改变当前委托合约 DelegateCall 中的状态变量值
// 在当前委托调用合约 DelegateCall 中没有修改状态变量的逻辑
// 被调用的合约变量布局需要和委托合约中的变量布局一致，新增变量在最后追加
contract TestDelegateCall{
    uint public num;
    address public sender;
    uint public value;
    // address public owner; // 新增变量放最后，否则被调用值会出现很奇怪的问题

    // 函数有三个状态变量要改变
    function setVars(uint _num) external payable{
        // num = _num;
        num = 2 * _num; // 如果修改了这里的逻辑，相当于采用新的逻辑修改了委托调用合约 DelegateCall 的变量值，形成升级合约的基本范式
        sender = msg.sender;
        value = msg.value;
    }
}

// 委托调用合约
contract DelegateCall{
    uint public num;
    address public sender;
    uint public value;

    // 让我们的调用委托到下一个合约中 TestDelegateCall
    function setVars(address _test, uint _num) external payable{
        // 写法1.用签名，低级call写法一样
        // _test.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num)); // 委托调用
        // 写法2.用selector，用合约的名字.方法名.selector
        (bool success,bytes memory data) = _test.delegatecall(abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)); // 委托调用
        require(success," delegatecall failed");
    }
}