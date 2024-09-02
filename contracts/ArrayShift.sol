// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 数组删除元素，通过移动位置删除，数组可以保持原有顺序，缺点是消耗gas量
contract ArrayShift {
    uint[] public arr;

    function examples() public {
        // delete 删除元素不改变数组长度，只能把数组元素恢复默认值。我们希望是数组元素删掉，长度减少
        arr = [1, 2, 3];
        delete arr[1]; // [1,0,3]
    }

    // [1,2,3] -- remove(1) -->[1,3,3]-->[1,3]
    // [1,2,3,4,5,6] -- remove(2) -->[1,2,4,5,6,6]-->[1,2,4,5,6] 删除索引2的值(3)之后，右侧左移。最后多了一个6，6用pop弹出删除
    // [1]-- remove(0) -->[1]-->[]
    function remove(uint _index) public {
        require(_index < arr.length, "index out of bounds"); // 防止数组越界
        // 循环从要删除的索引开始，到倒数第2个为止结束。把后面的元素往前移动
        for (uint i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        // 最后一个值弹出
        arr.pop();
    }

    // 测试函数
    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2); // [1,2,4,5]
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);

        arr = [1];
        remove(0); //[]
        assert(arr.length == 0);
    }
}
