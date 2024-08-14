// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract URKUToken is ERC20, Ownable {

    address public approvedContract;

    constructor() ERC20("Token", "TOK") Ownable(msg.sender){
        _mint(address(this), 586137525 * 10 ** (decimals() - 2));
    }

    function mintTokens(uint256 amount) external onlyOwner {
        _mint(address(this), amount * 10 ** decimals());
    }

    function burnTokens(address burnTokenAddress, uint256 amount) external onlyOwner {
        _burn(burnTokenAddress, amount * 10 ** decimals());
    }

    function transferTokens(address to, uint256 amount) external onlyOwner {
        require(balanceOf(address(this)) >= amount * 10 ** decimals(), "Not enough tokens in contract");
        _transfer(address(this), to, amount * 10 ** decimals());
    }

}