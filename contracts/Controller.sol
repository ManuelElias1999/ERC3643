// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./Compliance.sol";

contract Controller {
    Compliance private compliance;
    address public admin;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not an admin");
        _;
    }

    constructor(address _compliance) {
        compliance = Compliance(_compliance);
        admin = msg.sender;
    }

    function checkCompliance(address from, address to) external view returns (bool) {
        return compliance.canTransfer(from, to);
    }
}
