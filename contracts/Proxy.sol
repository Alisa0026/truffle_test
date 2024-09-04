// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 通过合约部署合约
contract TestContract1 {
    address public owner = msg.sender;
    // 设置管理员，要把管理员设置为我们自己的个人账户
    // 管理员只能由部署合约的部署者调用，部署合约的部署者是代理合约Proxy，代理合约怎么把管理员改成我们自己？
    function setOwner(address owner) public {
        require(msg.sender == owner, "not owner");
        owner = owner;
    }
}
contract TestContract2 {
    address public owner = msg.sender;
    uint public value = msg.value;
    uint public x;
    uint public y;

    constructor(uint _x, uint _y) payable {
        x = _x;
        y = _y;
    }
}

// 代理合约部署测试合约1/2
contract Proxy1 {
    // 部署方法，只能部署一个合约，希望代理合约可以通过把合约机器码输入进行部署
    function deploy(bytes memory _code) external payable {
        new TestContract1();
    }
}

// 代理合约部署测试合约2
contract Proxy2 {
    // 部署方法，只能部署一个合约，希望代理合约可以通过把合约机器码输入进行部署
    function deploy(bytes memory _code, uint x, uint y) external payable {
        new TestContract2(x, y);
    }
}

contract Proxy {
    // 通过事件向链外汇报新部署的地址
    event Deploy(address);

    // 代理合约还有收到主币的可能性，增加一个回退函数接收主币，否则报错
    fallback() external payable {}

    // 传入部署合约机器码,返回新部署的地址
    function deploy(
        bytes memory _code
    ) external payable returns (address addr) {
        // 内联汇编
        assembly {
            // create(v,p,n)
            // v = 发送以太坊主币的数量
            // p = 内存中合约机器码开始的位置
            // n = 内存中合约机器码的大小

            // 跳跃 0x20这个位置
            addr := create(callvalue(), add(_code, 0x20), mload(_code)) // 会返回地址
        }
        // 判断addr不是0地址才能成功
        require(addr != address(0), "deploy failed");
        // 触发事件
        emit Deploy(addr);
    }

    // 加一个执行方法,设置目标地址+传入参数
    function execute(address _target, bytes memory _data) external payable {
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success, "failed");
    }
}

// 助手函数
contract Helper {
    function getBytecode1() external pure returns (bytes memory) {
        // 得到部署合约需要的机器码
        bytes memory bytecode = type(TestContract1).creationCode;
        return bytecode;
    }

    function getBytecode2(
        uint _x,
        uint _y
    ) external pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract2).creationCode;
        // 测试合约2 有构造函数和参数，把输入参数x,y通过打包方式链接到bytecode之后
        return abi.encodePacked(bytecode, abi.encode(_x, _y));
    }

    function getCalldata(address _owner) external pure returns (bytes memory) {
        // 把设置管理员参数打包，加上输入变量
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
}
