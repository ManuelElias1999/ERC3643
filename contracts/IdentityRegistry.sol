// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract IdentityRegistry {
    struct Identity {
        bool isVerified;
        uint256 expirationDate;
    }

    mapping(address => Identity) private identities;
    address public admin;

    event IdentityAdded(address indexed user, uint256 expirationDate);
    event IdentityUpdated(address indexed user, uint256 newExpirationDate);
    event IdentityRemoved(address indexed user);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not an admin");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function addIdentity(address user, uint256 expirationDate) external onlyAdmin {
        identities[user] = Identity(true, expirationDate);
        emit IdentityAdded(user, expirationDate);
    }

    function updateIdentity(address user, uint256 newExpirationDate) external onlyAdmin {
        require(identities[user].isVerified, "Identity not found");
        identities[user].expirationDate = newExpirationDate;
        emit IdentityUpdated(user, newExpirationDate);
    }

    function removeIdentity(address user) external onlyAdmin {
        require(identities[user].isVerified, "Identity not found");
        delete identities[user];
        emit IdentityRemoved(user);
    }

    function isVerified(address user) external view returns (bool) {
        return identities[user].isVerified && identities[user].expirationDate > block.timestamp;
    }
}
