// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 小猪存钱罐
// 任何人可以发主币，只有合约部署者可以取出主币，都取完就可以自毁
contract PiggyBank {
    // 收款事件
    event Deposit(uint amount);
    // 取款事件
    event Withdraw(uint amount);

    address public owner = msg.sender;

    // 收款方法
    receive() external payable {
        emit Deposit(msg.value);
    }

    // 取款方法
    function withdraw() external {
        require(msg.sender == owner, "Only the owner can withdraw");
        emit Withdraw(address(this).balance); // 主币余额
        // 取款。发生给合约部署者
        selfdestruct(payable(msg.sender));
    }

}
