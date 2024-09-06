// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 钱包合约
// 制作一个以太坊钱包，通过钱包向合约存入一定数量的以太坊主币，可以随时从合约中取出存入的主币

contract EtherWallet {
    // 先规定一个管理员身份
    address payable public  owner;

    // 构造函数，在合约部署时执行一次，用来初始化管理员身份,部署者的身份传到变量中
    constructor() {
        owner = payable(msg.sender);
    }

    // 接收主币
    receive() external payable {}

    // 取出以太坊主币，将主币发给调用者
    function withdraw(uint _amount) external {
        // 检查调用者是否为管理员,只能合约的拥有者调用
        require(msg.sender == owner, "caller is not owner");
        // 向合约拥有者发主币
        // owner.transfer(_amount);
        payable(msg.sender).transfer(_amount); // 直接用msg.sender进行transfer，向内存中属性发送主币，节约gas

        // 可以用call发生主币，不用给msg.sender加payable属性
        // (bool sent,) = msg.sender.call{value: _amount}(""); // 通过call发送主币
        // require(sent, "Failed to send Ether");
    }

    // 查看合约余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
