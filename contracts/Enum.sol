// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 枚举
contract Enum {
    // 定义枚举类型
    enum Status {
        None,
        Pedding,
        Shipped,
        Completed,
        Rejected,
        Canceled
    }

    Status public status; // 用枚举类型定义变量

    // 结构体内部也可以写枚举类型
    struct Order {
        address buyer;
        Status status;
    }

    // 用结构体定义数组
    Order[] public orders;

    // 只读函数返回状态类型
    function get() external view returns (Status) {
        return status;
    }

    // 修改枚举类型的状态变量值
    function set(Status _status) external {
        status = _status;
    }
    // 枚举类型状态变量修改为指定状态值
    function ship() external {
        status = Status.Shipped;
    }
    // 枚举类型状态变量恢复到默认值
    function reset() external {
        delete status; // 删除状态变量，恢复默认值
        // 枚举类型的默认值是第一个值
    }
}
