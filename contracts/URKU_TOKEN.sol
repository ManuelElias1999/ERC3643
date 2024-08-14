// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract URKU is ERC20, Ownable {

    event ContractDeployed(address owner, uint256 initialSupply);
    event TokensMinted(address indexed owner, uint256 amount);
    event TokensBurned(address indexed owner, address burnTokenAddress, uint256 amount);
    event TokensTransferred(address indexed owner, address to, uint256 amount);

    constructor() ERC20("URKU", "URKU") Ownable(msg.sender) {
        uint256 initialSupply = 586137525 * 10 ** (decimals() - 2);
        _mint(address(this), initialSupply);
        emit ContractDeployed(msg.sender, initialSupply);
    }
    
    function mintTokens(uint256 amount) external onlyOwner {
        uint256 mintAmount = amount * 10 ** decimals();
        _mint(address(this), mintAmount);
        emit TokensMinted(msg.sender, mintAmount);
    }

    function burnTokens(address burnTokenAddress, uint256 amount) external onlyOwner {
        uint256 burnAmount = amount * 10 ** decimals();
        _burn(burnTokenAddress, burnAmount);
        emit TokensBurned(msg.sender, burnTokenAddress, burnAmount);
    }
    
    function transferTokens(address to, uint256 amount) external onlyOwner {
        uint256 transferAmount = amount * 10 ** decimals();
        require(balanceOf(address(this)) >= transferAmount, "Not enough tokens in contract");
        _transfer(address(this), to, transferAmount);
        emit TokensTransferred(msg.sender, to, transferAmount);
    }
}