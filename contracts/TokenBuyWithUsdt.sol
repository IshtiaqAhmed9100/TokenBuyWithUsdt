// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenBuyWithUsdt is Ownable, ERC20 {
    address public usdtTokenAddress;

    uint256 public ethPrice;
    uint256 public usdtPrice;

    constructor(
        address _usdtTokenAddress,
        uint256 _ethPrice,
        uint256 _usdtPrice
    ) Ownable(msg.sender) ERC20("TokenUSDT", "TUS") {
        usdtTokenAddress = _usdtTokenAddress;
        ethPrice = _ethPrice;
        usdtPrice = _usdtPrice;
    }

    function buyWithEther() external payable {
        require(msg.value >= ethPrice);

        _mint(msg.sender, msg.value);

    }

    function buyWithUSDT(uint256 amount) external {
        require(amount >= usdtPrice);
        require(IERC20(usdtTokenAddress).allowance(msg.sender, address(this)) >= amount);
        require(IERC20(usdtTokenAddress).balanceOf(msg.sender) >= amount);

        _mint(msg.sender, amount);
    }
}