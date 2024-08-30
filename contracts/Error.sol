// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 报错控制
// require， revert， assert
// gas 退还，状态变量回滚
// 8.0 新增自定义错误功能，节约gas特性
contract Error {
    function testRequire(uint _i) external pure {
        // 只有满足前面条件为真，才能运行后面代码，否则报错后面信息
        require(_i <= 0, "i > 10");
        // code
    }

    function testRevert(uint _i) external pure {
        // revert不能包含表达式，先写if判断
        // 报错，返回信息
        if (_i > 10) {
            // i>10才报错
            revert("i > 10");
        }

        // 也可以嵌套多层if
        if (_i > 1) {
            // code
            if (_i > 2) {
                // more code
                if (_i > 10) {
                    // i>10才报错
                    revert("i > 10");
                }
            }
        }
        // code
    }

    uint public num = 123;

    function testAssert() public view {
        // assert只能用于内部错误，不能用于用户输入错误
        assert(num === 123); // 断言不包含报错信息
    }

    function foo() public {
        // num+1以后不满足上面assert断言条件，会报错
        num+=1;
    }

    // 用自定义错误节约gas,括号里可以加一些变量，方便调试
    error MyError(address caller,uint i);

    function testCustomError(uint _i) public view{
        // 自定义错误
        // require(_i <=10, "very long error message error error error error error"); // 报错信息非常长回浪费很多gas

        if(_i > 10){
            revert MyError(msg.sender, _i); // 报错信息非常短，节约很多gas
        }
    }
}
