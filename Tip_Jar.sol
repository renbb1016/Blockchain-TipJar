// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Tipjar is Ownable{

mapping(address => uint256) private tips;
uint256 private totalTips;

event Tipped(
    address sender,
    uint256 amount,
    uint256 newTotal
);

constructor() Ownable(msg.sender) {}

function tip() external payable  {
    require(msg.value > 0, "Deposit must be greater than zero");
    tips[msg.sender] += msg.value;
    totalTips += msg.value;
    emit Tipped(msg.sender,msg.value,tips[msg.sender]);
}

function totalTipped(address sender) external view returns (uint256){
    return(tips[sender]);
}

function totalRecieved() external view returns (uint256){
    return totalTips;
}

function withdraw() external onlyOwner{
    uint256 balance = address(this).balance;
    (bool success, ) = payable(owner()).call{value: balance}("");
    require(success, "Withdrawal failed");
}

}