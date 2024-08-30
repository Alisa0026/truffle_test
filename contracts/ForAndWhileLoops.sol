// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ForAndWhileLoops {
    function loops(uint _x) external pure {
        for (uint i = 0; i < 10; i++) {
            // code
            if (i == 3) {
                continue; // 跳过本次循环，继续下一次循环
            }
            // more code
            if (i == 5) {
                break; // 彻底 跳出循环
            }
        }

        uint j = 0
        while (j<10) {
            // code
            j++;
        }
    }

    // 累加器,智能合约中n不能太大，造成gas的浪费，要控制循环数量
    function sum(uint _n) external pure returns (uint) {
        uint s = 0;
        for (uint i = 1; i <= _n; i++) {
            s += i;
        }
        return s;
    }
}
