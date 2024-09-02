// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 删除数组元素-通过替换方式，打乱数组顺序
contract ArrayReplaceLast {
    uint[] public arr;

    // [1,2,3,4] -- remove(1) -->[1,4,3]
    // [1,4,3] ---remove(2)-->[1,4]
    function remove(uint _index) public {
        require(_index < arr.length, "index out of bounds"); // 防止数组越界
        arr[_index] = arr[arr.length - 1]; // 把最后一个元素移到要删除的位置
        arr.pop(); // 删除最后一个元素
    }

    // 测试函数
    function test() external {
        arr = [1, 2, 3, 4];
        remove(1); // [1,4,3]
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);
        assert(arr.length == 3);

        // [1, 4, 3];
        remove(2); // [1,4]
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr.length == 2);
    }
}
