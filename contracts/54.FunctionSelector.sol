// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 函数签名,函数选择器，代表虚拟机怎么找到函数的

contract Receiver {
    event Log(bytes data);

    function transfer(address payable _to, uint _amount) external payable{
        emit Log(msg.data);
    }
}

// 获取函数选择器的合约
contract FunctionSelector {
    function getSelector(string calldata _func) external pure returns(bytes4){
        return bytes4(keccak256(bytes(_func)));
    }
}
