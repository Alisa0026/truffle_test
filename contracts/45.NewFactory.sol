// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 工厂合约
// 合约部署合约的方法，之前是通过内联汇编调用: Proxy.sol 中.这次通过new 语句
contract Account {
    address public bank;
    address public owner;

    constructor(address _owner) payable {
        bank = msg.sender; // 找合约部署者的地址是工厂合约
        owner = _owner;
    }
}

// 账户工厂，可以和账户合约在一个文件中，如果不在一个文件，账户合约导入就行
contract AccountFactory {
    Account[] public accounts;

    // 传递主币 {value:111}
    function createAccount(address _owner) external payable {
        // 通过 new 创建合约
        Account account = new Account{value: 111}(_owner);
        accounts.push(account);
    }
}
