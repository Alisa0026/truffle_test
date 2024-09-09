// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 证书合约
contract CertificateRegistry {
    struct Certificate {
        string name;
        string id;
        uint256 score;
        uint256 timestamp;
    }

    // Mapping from user ID to Certificate
    mapping(string => Certificate) private certificates;

    event CertificateIssued(string indexed id, string name, uint256 score, uint256 timestamp);

    // Function to issue a certificate
    function issueCertificate(string memory name, string memory id, uint256 score) public {
        require(bytes(id).length > 0, "ID cannot be empty");
        require(bytes(name).length > 0, "Name cannot be empty");
        require(score >= 0, "Score must be non-negative");
        require(bytes(certificates[id].id).length == 0, "Certificate already exists");

        certificates[id] = Certificate(name, id, score, block.timestamp);
        emit CertificateIssued(id, name, score, block.timestamp);
    }

    // Function to get a certificate by user ID
    function getCertificateById(string memory id) public view returns (string memory, string memory, uint256, uint256) {
        require(bytes(certificates[id].id).length > 0, "Certificate not found");

        Certificate memory cert = certificates[id];
        return (cert.name, cert.id, cert.score, cert.timestamp);
    }

    // Function to verify a certificate by user ID and name
    function verifyCertificate(string memory id, string memory name) public view returns (bool) {
        Certificate memory cert = certificates[id];
        if (keccak256(abi.encodePacked(cert.name)) == keccak256(abi.encodePacked(name)) && keccak256(abi.encodePacked(cert.id)) == keccak256(abi.encodePacked(id))) {
            return true;
        }
        return false;
    }
}
