// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 结构体：很多变量格式打包组合在一起的数据个性
contract Structs {
    // 定义结构体
    struct Car{
        string model;
        uint year;
        address owner;
    }

    Car public car; // 以结构体类型定义汽车变量
    Car[] public cars; // 以结构体类型定义定义数组
    mapping(address => Car) public carsByOwner;// 以结构体类型定义定义映射，一个人可能拥有许多辆汽车

    function examples() external {
        // 函数中声明局部变量
        // 标记类型是内存
        Car memory toyota = Car("Toyota", 1990, msg.sender); // 向结构体内传入数据
        Car memory lambo = Car({model:'Lamborghini', year:1980, owner:msg.sender}); // 用对象的方式传入数据，不用一定按照顺序
        Car memory tesla; // 不填值会以默认值存在
        tesla.model = "Tesla";
        tesla.year = 2010;
        tesla.owner = msg.sender;

        // 结构体数组
        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        cars.push(Car("Ferrari", 2000, msg.sender)); // 直接传入数据,在内存中建立的结构体推入到数组中，记录到状态变量中了，不是局部变量了

        // 获取结构体的值
        Car memory _car = cars[0]; // 从数组中取出结构体
        // 可以使用结构体具体某个变量的值
        _car.model;
        _car.year;
        _car.owner;
        
        // 如果结构体定义在存储中，可对结构体的值进行修改删除，带指针式的读取出来
        Car storage _car2 = cars[0]; // 从数组中取出结构体
        _car2.year = 1991; // 修改结构体中的值
        delete _car2.owner; // 删除结构体中的值，恢复到默认值

        delete cars[1]; // 对整个数组中的元素删除
       
    }
}
