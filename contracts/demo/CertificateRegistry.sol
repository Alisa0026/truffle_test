// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CertificateRegistry {
    struct Certificate {
        string CertNumber;
        string UserName;
        uint256 Score;
        uint256 Time;
    }

    event issueCertificateEvent(string indexed certNumber, string indexed userName, uint256 score, uint256 time);

    mapping(string => Certificate) private certificates;
    string[] private certNumbers=["1"];

    function issueCertificate(string memory certNumber, string memory userName, uint256 score, uint256 time) public {
        require(!stringsEquals(certNumber, ""), "Certificate number cannot be null");
        require(!stringsEquals(userName, ""), "User name cannot be null");
        require(!certificateExists(certNumber), "Certificate with this number already exists");

        certificates[certNumber] = Certificate({
            CertNumber: certNumber,
            UserName: userName,
            Score: score,
            Time: time
        });

        certNumbers.push(certNumber);

        emit issueCertificateEvent(certNumber, userName, score, time);
    }

    function findByCertNumber(string memory certNumber) public view returns (string memory, string memory, uint256, uint256) {
        Certificate memory cert = certificates[certNumber];
        require(cert.Time != 0, "Certificate not found");
        return (cert.CertNumber, cert.UserName, cert.Score, cert.Time);
    }

    function verifyCertificate(string memory certNumber, string memory userName) public view returns (bool) {
        Certificate memory cert = certificates[certNumber];
        return (cert.Time != 0 && stringsEquals(cert.UserName, userName));
    }

    function getAllCertNumbers() external view returns (string[] memory) {
        return certNumbers;
    }

    function stringsEquals(string memory s1, string memory s2) private pure returns (bool) {
        bytes memory b1 = bytes(s1);
        bytes memory b2 = bytes(s2);
        uint256 l1 = b1.length;
        if (l1 != b2.length) return false;
        for (uint256 i = 0; i < l1; i++) {
            if (b1[i] != b2[i]) return false;
        }
        return true;
    }
    function certificateExists(string memory certNumber) private view returns (bool) {
        return certificates[certNumber].Time != 0;
    }

}
