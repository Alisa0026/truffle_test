// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 库合约
// 常用算法抽成库合约，库合约一般是合约内部使用的，所以定义为内部可视 internal
library Math {
    // 找x，y最大值
    function max(uint x, uint y) internal pure returns (uint) {
        return x > y ? x : y;
    }
}

contract Text {
    // 找x，y最大值
    function testMax(uint x, uint y) external pure returns (uint) {
        return Math.max(x, y);
    }
}

library Arraylib {
    // 数组存储位置是内存用 storage，第二个是寻找的数字x
    function find(uint[] storage arr, uint x) internal view returns (uint) {
        for (uint i = 0; i < arr.length; i++) {
            if (arr[i] == x) {
                return i;
            }
        }
        revert("Not found");
    }
}

contract TextArray {
    using Arraylib for uint[]; // 把库应用到数组的类型中，这个类型就拥有了这个库所有函数的功能
    uint[] public arr = [3, 2, 1];

    // 寻找数组特定值对应的索引
    function testFind() external view returns (uint i) {
        // return Arraylib.find(arr, 2);
        return arr.find(2); // 使用 using for 语法，可以直接使用库合约的函数
    }
}
