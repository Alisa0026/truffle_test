// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//  接口
// 如果不知道另一个合约的源代码，或者合约的源代码非常庞大，可以通过接口调用
contract Counter {
    uint public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}

// 接口合约
interface ICounter {
    function count() external view returns (uint); // 写调用函数的名称，不实现就可以
    function inc() external;
}

contract CallInterface {
    uint public count;

    function examples(address _counter) external {
        // Counter(_counter).inc();
        ICounter(_counter).inc(); // 以接口合约为类型，调用Counter合约
        count = ICounter(_counter).count(); // count在Counter是public变量，获取一下，更新本合约中的count值
    }
}
