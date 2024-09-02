// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 数组- 动态数组、固定长度数组
// 数组初始化
// insert(push),get,update,delete,pop,length
// creating array in memory 内存中创建数组
// returning array from function 从函数中返回数组

contract Array {
    // 动态数组
    uint[] public nums = [1, 2, 3];
    // 定长数组,长度不变
    uint[3] public numsFixed = [4, 5, 6];

    function examples() external{
        // 动态数组可以push，定长不可以
        nums.push(4); // [1, 2, 3, 4]
        // 通过索引访问值
        uint x = nums[1]; // 2
        // 通过索引修改
        nums[2] = 777; // [1, 2, 777, 4] 
        // 删除,不会修改数组长度，只是把值置为默认值，uint默认值0
        delete nums[1]; // [1, 0, 777, 4]
        // 弹出最后一个元素
        nums.pop(); // [1, 0, 777]
        // 获取数组长度
        uint len = nums.length; // 3

        // 创建内存中的数组 memory 关键词
        // 内存中不能创建动态数组，要给长度
        uint[] memory a = new uint[](5);
        // a.pop(); // 错误，内存中不能pop/push，因为会改变数组长度
        // 通过索引修改
        a[1]=123;

        // 小结：内存中局部变量只能定义定长数组，动态数组只能存在状态变量中
    }

    // 通过函数返回数组所有内容
    // 返回值数组，是memory存储类型
    function returnArray() external view returns (uint[] memory){
        return nums;
    }


}
