// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract FT is ERC20 {
    address public owner;
    bool private paused;
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        paused = false;
        owner = msg.sender;

    }
    modifier Onlyowner{
        require(msg.sender == owner);
        _;
    }

    modifier whenPaused{
        require(paused);
        _;
    }
    modifier whenNotPaused{
        require(!pasued);
    }

    // TODO 实现mint的权限控制，只有owner可以mint
    function mint(address account, uint256 amount) external Onlyowner {
        _mint(account,amount);

    }

    // TODO 用户只能燃烧自己的token
    function burn(uint256 amount) external {
        _burn(msg.sender,amount);
    }

    // TODO 加分项：实现transfer可以暂停的逻辑
    function transfer(address to, uint256 amount) override public whenNotPaused returns (bool) {
        return super.transfer(to, amount);
    }
    function pause() public onlyOwner whenNotPaused {
    paused = true;
    
    }

    function unpause() public onlyOwner whenPaused {
    paused = false;
    
    }
        

    }

