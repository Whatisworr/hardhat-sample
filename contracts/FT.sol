// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FT is ERC20 {

    constructor(string memory name, string memory symbol) ERC20(name, symbol) payable{
        _owner = msg.sender;
    }

    address public _owner;
    mapping(address => uint256) _balances;
    bool public paused = false;

    modifier onlyOwner() {
        require(msg.sender == _owner, "You are not the owner");
        _;
    }

    // TODO 实现mint的权限控制，只有owner可以mint
    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }

    // TODO 用户只能燃烧自己的token
    function burn(uint256 amount) external{
        _burn(msg.sender, amount);
    }

    // TODO 加分项：实现transfer可以暂停的逻辑
    function transfer(address to, uint256 amount) public override returns(bool){
        require(paused == false, "Function Paused!");
        require(_balances[msg.sender] >= amount, "No enough tokens.");
        return super.transfer(to, amount);
    }

    function setPaused(bool _paused) public onlyOwner{
       paused = _paused;
   }
}
