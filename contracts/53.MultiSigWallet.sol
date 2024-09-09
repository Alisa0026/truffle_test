// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 多签钱包合约
// 多个人同意才能把合约中的主币向外转出
contract MultiSigWallet {
    // 存款事件
    event Deposit(address indexed sender, uint amount);
    // 提交一个交易申请
    event Submit(uint indexed txId);
    // 合约签名人批准
    event Approve(address indexed owner, uint indexed txId);
    // 撤销批准
    event Revoke(address indexed owner, uint indexed txId);
    // 执行
    event Execute(uint indexed txId);


// 交易结构体
    struct Transaction {
        address to; // 发送目标地址
        uint value; // 主币数量
        bytes data; // 如果目标地址合约地址，可以执行合约中的函数
        bool executed; // 是否被执行
    }

    address[] public owners; // 保存合约所有的签名人
    mapping(address => bool) public isOwner; // 记录某个地址是否是签名人
    uint public required; // 最少要满足的签名人数目

    Transaction[] public transactions; // 保存所有交易
    // 交易id对应签名人的地址，对应bool，记录某个交易id下某个签名人的地址是否批准了这次交易。
    mapping(uint => mapping(address => bool)) public approved; // 交易id映射到交易

    modifier onlyOwner(){
        require(isOwner[msg.sender], "not owner");
        _;
    }

    // 交易id是否存在，交易id都是数组索引，所以用数组长度来判断
    modifier txExists(uint _txId){
        require(_txId < transactions.length, "tx does not exist");
        _;
    }
    // 交易id是否已经被批准
    modifier notApproved(uint _txId){
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }
    // 交易id是否已经被执行
    modifier notExecuted(uint _txId){
        require(!transactions[_txId].executed, "tx already executed");
        _;
    }

    // 构造函数传入合约签名人所有地址
    constructor(address[] memory _owners,uint _required){
        require(_owners.length > 0, "owners required");// 地址数组长度要大于0
        require(_required > 0 && _required <= _owners.length, "required error"); // 确认数也大于0，小于地址数组长度

        // 每个地址有效，且不重复
        for(uint i = 0; i < _owners.length; i++){
            address owner = _owners[i];
            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner not unique");
            isOwner[owner] = true;
            owners.push(owner);
        }
        required = _required; // 确认数赋值
    }

    // 合约可以接收主币
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // 提交交易
    function submit(address _to, uint _value, bytes calldata _data) external onlyOwner {
        transactions.push(Transaction({
            to: _to,
            value: _value,
            data: _data,
            executed: false
        }));
        uint txId = transactions.length - 1; // 交易id，数组长度-1
        emit Submit(txId);
    }

    // 批准
    function approve(uint _txId) external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId) {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }
    // 内部函数，计算某个交易id下的签名人多少人批准了
    function _getApprovalCount(uint _txId) private view returns (uint count){
        for(uint i = 0; i < owners.length; i++){
            if(approved[_txId][owners[i]]){
                count += 1;
            }
        }
        // return count;// 隐式返回
    }

    // 执行方法
    function execute(uint _txId) external txExists(_txId) notExecuted(_txId) {
        // 交易id确认数达到多少
        require(_getApprovalCount(_txId) >= required, "not enough approvals");
        // 交易结构体拿出
        Transaction storage transaction = transactions[_txId];
        // 已执行修改true
        transaction.executed = true;
        // 对目标地址进行低级call
        (bool success, ) = transaction.to.call{value: transaction.value}(transaction.data);
        require(success, "tx failed");
        emit Execute(_txId);
    }

    // 撤销
    function revoke(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
        require(approved[_txId][msg.sender], "tx not approved"); // 判断这个id下的签名人已经签名过了，才能撤销
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
    }
}
