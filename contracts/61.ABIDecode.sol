// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// abi解码
contract AbiDecode {
    struct MyStruct {
        string name;
        uint[2] nums;
    }

    function encode(
        uint x,
        address addr,
        uint[] calldata arr,
        MyStruct calldata myStruct
    ) external pure returns (bytes memory) {
        return abi.encode(x, addr, arr, myStruct); // 编码
    }

    // 解码
    function decode(
        bytes calldata data
    )
        external
        pure
        returns (
            uint x,
            address addr,
            uint[] memory arr,
            MyStruct memory myStruct
        )
    {
        return abi.decode(data, (uint, address, uint[], MyStruct));
    }
}
