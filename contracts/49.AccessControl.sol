// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 权限控制合约
contract AccessControl {
    // 修改变量的值要弄个事件
    event GrantRole(bytes32 indexed role, address indexed account); // 事件，记录授权
    event RevokeRole(bytes32 indexed role, address indexed account); // 事件，撤销权限

    // 合约中有多种角色身份
    // role => account => bool
    mapping(bytes32 => mapping(address => bool)) roles; // 角色对应一个映射
    // hash 做成名称,两个角色名称定义
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN")); // keccak256是一个哈希函数，把字符串转换成哈希值
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    // 函数修改器
    modifier onlyRole(bytes32 _role) {
        require(roles[_role][msg.sender], "not authorized");
        _;
    }

    // 构造函数中把管理员的权限赋予给合约的部署者
    constructor() {
        _grantRole(ADMIN, msg.sender);
    }

    // 内部升级函数，映射中定义想要升级的账户地址，给账户地址赋予权限
    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    // 外部升级函数，只管理员才能调用（会检查权限）
    function grantRole(
        bytes32 _role,
        address _account
    ) external onlyRole(ADMIN) {
        _grantRole(_role, _account);
    }

    // 撤销权限
    function revokeRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    }
}
