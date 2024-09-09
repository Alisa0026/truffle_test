// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 通过智能合约验证签名 4步
/**
0. message to sign 消息签名
1. hash(message) 消息hash
2. sign(hash(message),privateKey)| offchain 消息和私钥签名-在链下完成
3. ecrecover(hash(message),singature) == signer  恢复签名：ecrecover 通过链下签名和 hash(message) 恢复出签名人


// 在Remix中，打开控制台
ethereum.enable() 打开以太坊的插件，必须装methmask才能打开这个功能

ethereum.request({ method: 'persion_sign', params:[account,hash]})  // 运行调用以太坊的签名程序，打开methmask，点确认产生一个签名结果

 */
contract VerifySign {
    // 签名人地址,签名消息，签名结果，返回bool，判断签名人和恢复的是不是一个人
    function verify(
        address _signer,
        string memory _message,
        bytes memory _sig
    ) external pure returns (bool) {
        // 1. hash(message)
        bytes32 messageHash = getMessageHash(_message); //keccak256(abi.encodePacked(_message));
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    // 消息hash
    function getMessageHash(
        string memory _message
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    function getEthSignedMessageHash(
        bytes32 _messageHash
    ) public pure returns (bytes32) {
        return
            keccak256(
                abi.encodePacked(
                    "\x19Ethereum Signed Message:\n32",
                    _messageHash
                )
            );
    }

    // 恢复函数
    function recover(
        bytes32 _ethSignedMessageHash,
        bytes memory _sig
    ) public pure returns (address) {
        // 非对称算法
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    // 分割签名
    function _split(
        bytes memory _sig
    ) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        // 签名长度是65
        require(_sig.length == 65, "invalid signature length");
        // 使用内联汇编进行分割
        assembly {
            // mload 内存中的读取，add跳过一个长度32位之后的位置
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96))) // v 是uint8类型，所以取一个字节
        }
    }
}
