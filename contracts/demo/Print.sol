// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Strings.sol)

pragma solidity >0.4.22;

contract Print {
    //字符串转换方法，可以将无符号整型转换为一个string
    function toStr(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }

        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }

        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }

        return string(buffer);
    }

    //字符串转换方法，可以将一个布尔值转换为一个string
    function toStr(bool value) internal pure returns (string memory) {
        if (value) {
            return "true";
        } else {
            return "false";
        }
    }

    //打印方法，调用该方法可以将一个字符串写入日志文件或者打印到控制台，打印内容以 evm log>> 前缀开头
    //arg level: 日志打印级别，参数取值列表[0-debug，1-info, 2-warning, 3-error]
    //arg logs: 被打印内容
    function print(uint level, string memory logs) internal view {
        string memory levelStr = toStr(level);
        string memory inputStr = string(abi.encodePacked(levelStr, logs));
        bytes memory input = bytes(inputStr);

        bytes32[2] memory result;
        uint256 len = input.length;
        assembly {
            let ok := staticcall(0, 0x03ee, add(input, 0x20), len, result, 0x40)
            switch ok
            case 0 {
                revert(0, 0)
            }
        }
    }
}
