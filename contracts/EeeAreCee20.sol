pragma solidity ^0.8.10;

import "./IERC20.sol";

// is IERC20
contract EeeAreCee20Token {
	// Internal vars
	mapping (address => uint256) private _balances;
	mapping (address => mapping (address => uint256)) private _allowances;
	uint public totalSupply;
	string private _name;
    string private _symbol;
    uint8 private _decimals;

	// Ctor
	constructor(uint _totalSupply) {
		totalSupply = _totalSupply;
	}

	// Set total number of tokens


	// Read total number of tokens
	function getCirculation() public returns (uint) {
		return totalSupply;
	} 
}