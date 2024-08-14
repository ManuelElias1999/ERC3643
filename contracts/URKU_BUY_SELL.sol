// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./URKU_TOKEN.sol"; 

contract URKUTokenSale is Ownable {

    IERC20 public immutable usdcToken;
    URKUToken public immutable urkuToken;
    uint256 public tokenPrice = 0.01 * 10 ** 6; 

    constructor(address _urkuTokenAddress) Ownable(msg.sender){
        usdcToken = IERC20(0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913);
        urkuToken = URKUToken(_urkuTokenAddress);
    }

    function buyTokens(uint256 usdcAmount) external {
        require(usdcAmount > 0, "USDC amount 0");
        uint256 tokenAmount = usdcAmount / tokenPrice;
        
        usdcToken.transferFrom(msg.sender, address(this), usdcAmount);

        urkuToken.transfer(msg.sender, tokenAmount * 10 ** urkuToken.decimals());
    }

    function setTokenPrice(uint256 newPrice) external onlyOwner {
        require(address(this) == urkuToken.approvedContract(), "Not authorized");
        tokenPrice = newPrice;
    }

    // Función para cambiar la billetera que recibe los fondos
    /*function setURKUWallet(address newWallet) external onlyOwner {
        require(address(this) == urkuToken.approvedContract(), "Not authorized");
        urkuWallet = newWallet;
    }*/
    function withdrawUSDC(address to, uint256 amount) external onlyOwner {
        uint256 contractBalance = usdcToken.balanceOf(address(this));
        require(contractBalance >= amount, "Insufficient balance");
        require(usdcToken.transfer(to, amount), "USDC transfer failed");
    }
}