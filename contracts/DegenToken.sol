// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    event LogMessage(string message);
    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {}

    string public redeemOptions =
        "1. Weapon Skin: 10 token \n 2. Primogems: 20 tokens \n 3. Character Skin: 30 tokens";
    
    mapping (address => uint[3]) items;

    //Minting new tokens
    function mint(address to, uint amount) public onlyOwner {
        _mint(to, amount);
    }

    //Transferring tokens
    function transferTokens(address _receiver, uint _value) external {
        require(balanceOf(msg.sender) >= _value, "INSUFFICIENT TOKENS!!");
        approve(msg.sender, _value);
        transferFrom(msg.sender, _receiver, _value);
    }

    //Redeeming tokens
    function redeemForItem(uint256 itemNo) public {
        uint256 amount;

        if (itemNo == 1) {
            amount = 10;
            items[msg.sender][0] += 1;

        } else if (itemNo == 2) {
            amount = 20;
            items[msg.sender][1] += 1;
        } else if (itemNo == 3) {
            amount = 30;
            items[msg.sender][2] += 1;
        } else {
            emit LogMessage("Redemption was UN-Successful");
            return;
        }

        _burn(msg.sender, amount);
        emit LogMessage("Redemption is Successful");
    }

    function getItems() view public returns (string[3] memory) {
        return [ string.concat("Weapon Skin: " , Strings.toString(items[msg.sender][0]))  , string.concat("Primogems: " , Strings.toString(items[msg.sender][1])) , string.concat("Character Skin: " , Strings.toString(items[msg.sender][2])) ];
    }

    //Checking token balance
    function getBalance() external view returns (uint256) {
        return this.balanceOf(msg.sender);
    }

    //Burning tokens
    function burnTokens(uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "INSUFFICIENT TOKENS!!");
        _burn(msg.sender, _value);
        emit LogMessage("Tokens burned successfully");
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }
}
