// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Controller.sol";

contract RegulatedToken is ERC20 {
    Controller private controller;
    address public admin;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not an admin");
        _;
    }

    constructor(
        string memory name,
        string memory symbol,
        address _controller
    ) ERC20(name, symbol) {
        controller = Controller(_controller);
        admin = msg.sender;
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override {
        require(controller.checkCompliance(from, to), "Compliance check failed");
        super._beforeTokenTransfer(from, to, amount);
    }

    function mint(address to, uint256 amount) external onlyAdmin {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external onlyAdmin {
        _burn(from, amount);
    }
}
