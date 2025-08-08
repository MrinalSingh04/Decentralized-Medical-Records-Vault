// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

/**
 * @title MedicalRecordsVault
 * @dev A decentralized vault for storing encrypted medical record hashes, with patient-controlled access.
 */
contract MedicalRecordsVault {
    struct Record {
        string recordHash; // IPFS or encrypted hash of the medical record
        uint256 timestamp;
    }

    // Mapping: patient => doctor => permission expiry timestamp
    mapping(address => mapping(address => uint256)) public accessPermissions;

    // Mapping: patient => their medical records
    mapping(address => Record[]) public patientRecords;

    event RecordAdded(address indexed patient, string recordHash, uint256 timestamp);
    event AccessGranted(address indexed patient, address indexed doctor, uint256 expiresAt);
    event AccessRevoked(address indexed patient, address indexed doctor);

    /**
     * @dev Add a new medical record.
     * @param _recordHash IPFS or other encrypted hash
     */
    function addRecord(string memory _recordHash) external {
        patientRecords[msg.sender].push(Record({
            recordHash: _recordHash,
            timestamp: block.timestamp
        }));

        emit RecordAdded(msg.sender, _recordHash, block.timestamp);
    }

    /**
     * @dev Grant access to a doctor for a limited time.
     * @param _doctor Address of the doctor
     * @param _duration Duration in seconds
     */
    function grantAccess(address _doctor, uint256 _duration) external {
        uint256 expiresAt = block.timestamp + _duration;
        accessPermissions[msg.sender][_doctor] = expiresAt;

        emit AccessGranted(msg.sender, _doctor, expiresAt);
    }

    /**
     * @dev Revoke access before expiry.
     * @param _doctor Address of the doctor
     */
    function revokeAccess(address _doctor) external {
        accessPermissions[msg.sender][_doctor] = 0;
        emit AccessRevoked(msg.sender, _doctor);
    }

    /**
     * @dev Get patient's records if caller is the patient or has valid access.
     */
    function getPatientRecords(address _patient) external view returns (Record[] memory) {
        require(
            msg.sender == _patient || accessPermissions[_patient][msg.sender] >= block.timestamp,
            "Access denied"
        );
        return patientRecords[_patient];
    }

    /**
     * @dev Check access status to a patient's records.
     */
    function hasAccess(address _patient, address _doctor) external view returns (bool) {
        return accessPermissions[_patient][_doctor] >= block.timestamp;
    }
}
