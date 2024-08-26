// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./IdentityRegistry.sol";

contract Compliance {
    IdentityRegistry private identityRegistry;
    address public admin;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not an admin");
        _;
    }

    constructor(address _identityRegistry) {
        identityRegistry = IdentityRegistry(_identityRegistry);
        admin = msg.sender;
    }

    function canTransfer(address from, address to) external view returns (bool) {
        bool fromVerified = identityRegistry.isVerified(from);
        bool toVerified = identityRegistry.isVerified(to);
        bool result = fromVerified && toVerified;
        return result;
    }
}
