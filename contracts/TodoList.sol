// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 待办事项列表
// 插入、修改、读取数据
contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    // 创建
    function create(string calldata _text) external {
        todos.push(Todo(_text, false));
    }

    // 更新
    function updateText(uint _index, string calldata _text) external {
        // 更新结构体里的一个内容，用这个节约gas
        todos[_index].text = _text;

        // 有很多数据要更新，用这个先存到storage存储中
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    // 获取
    function get(uint _index) external view returns (string memory, bool) {
        // 存到 memory 内存中，消耗gas多，存到storage 中，消耗gas少
        Todo memory todo= todos[_index];
        return (todo.text, todo.completed);
    }
    // 改变完成状态
    function toggleCompleted(uint _index) public {
        todos[_index].completed = !todos[_index].completed;
    }
}
