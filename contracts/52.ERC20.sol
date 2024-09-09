// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// ERC20标准合约
// IERC20标准只包括接口
// https://web3dao-cn.github.io/solidity-example/app/erc20/

interface IERC20 {
    // 当前合约token总量
    function totalSupply() external view returns (uint);
    // 代表某个账户当前余额
    function balanceOf(address account) external view returns (uint);
    // 把账户余额由当前调用者发到另一个账户中，transfer是写入方法，会向链外汇报transfer事件，可以查询token流转
    function transfer(address recipient, uint amount) external returns (bool);
    // 查询某个账户对另一个账户批准额度
    function allowance(
        address owner,
        address spender
    ) external view returns (uint);
    // 批准，把我账户的数量批准给另一个账户
    function approve(address spender, uint amount) external returns (bool);
    // 向另一个合约存款，需要另一个合约调用transferFrom 才能把我们账户的token拿到他的合约中
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint amount);

    event Approval(address indexed owner, address indexed spender, uint amount);
}

contract ERC20 is IERC20 {
    uint public totalSupply; // 当前合约token总量
    mapping(address => uint) public balanceOf; // 一个地址对应一个数组就可以组成一个账本。代表某个账户当前余额
    mapping(address => mapping(address => uint)) public allowance; // 发送者的地址对应被批准的地址，再对应数量组成批准映射。查询某个账户对另一个账户批准额度

    string public name = "Test"; // 给token起名
    string public symbol = "TEST"; // token缩写，用大写
    uint8 public decimals = 18; // token 精度，18位。1个整数1后面有18个0的小数。智能合约中只能记录整数，不能记录小数

    // 发送方法
    function transfer(address recipient, uint amount) external returns (bool) {
        // 发生者账户减一个数，接受者加一个数.实现一个转账
        balanceOf[msg.sender] -= amount; // 消息调用者账户减数
        balanceOf[recipient] += amount; // 接受者账户加数
        emit Transfer(msg.sender, recipient, amount);
        return true; // 返回true，如果前面数学溢出就到不了这里
    }

    // 批准。修改批准映射
    function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount; //当前合约的调用者msg.sender， 再找被授权账户spender，然后授权一个数量amount，赋值0就是相当于取消授权
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // 函数的调用者就是批准额度中的被批准的账户
    // 发送者对应的就是批准额度中的调用者
    function transferFrom(
        address sender, // 发送者
        address recipient, // 接受者
        uint amount // 数量
    ) external returns (bool) {
        allowance[sender][msg.sender] -= amount; // 发送者对应被批准账户（当前消息调用者）他的被批准额度减一个数
        balanceOf[sender] -= amount; // 发生者账户减一个数
        balanceOf[recipient] += amount; // 接受者加一个数
        emit Transfer(sender, recipient, amount);
        return true;
    }


    // 合约部署后，要给账户增加余额，这里制作一个铸币方法

    // 铸币方法，给消息调用者增加数量。应该有权限控制
    function mint(address account, uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount); // 0地址发送的token，都是铸币事件
    }
    // 销毁方法
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount); // 消息调用者发给0地址
    }
}
