pragma solidity ^0.8.10;

import "./IERC20.sol";
import "./SafeMath.sol";

contract EeeAreCee20Token is IERC20 {
	// Use safemath to prevent overflows	
	using SafeMath for uint256;

	/* Internal Vars */
	mapping (address => uint256) private _balances;
	mapping (address => mapping (address => uint256)) private _allowances;
	uint private _totalSupply;
	string private _name;
    string private _symbol;
    uint8 private _decimals; // Order of magnitude of wei -> token (1 EeeAreCee20Token == 10 ** (_decimals) wei)
    address _owner;

    modifier isOwner {
    	require (msg.sender == _owner,
            "Only owner may access.");
    	_;
    }

	/* Ctor */
	constructor(string memory name_, string memory symbol_) public {
		_name = name_;
		_symbol = symbol_;
		_decimals = 18;
		_owner = msg.sender; // set owner as creater of contract
	}

	/* Get Funcs */
	function name() public view returns (string memory) {
		return _name;
	}

	function symbol() public view returns (string memory) {
		return _symbol;
	}

	function decimals() public view returns (uint8) {
		return _decimals;
	}

	/* Read State Functions */
	function totalSupply() public view returns (uint) {
		return _totalSupply;
	}

	function balanceOf(address account) public view override returns (uint256) { // why is this not virtual
		return _balances[account];
	}

	/* Transfer Tokens */
	function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
		_transfer(msg.sender, recipient, amount);
		return true;
	}

	/* Allowance functions */
	function allowance(address owner, address spender) public view virtual override returns (uint256) {
		return _allowances[owner][spender];
	}

	function approve(address spender, uint256 amount) public virtual override returns (bool) {
		_approve(msg.sender, spender, amount);
		return true;
	}

	function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns(bool) {
		_transfer(sender, recipient, amount);
		_approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount, "ERC20: Transfer amount exceeds allowance"));
		return true;
	}

	function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
		_approve(msg.sender, spender, _allowances[msg.sender][spender].add(addedValue));
		return true;
	}

	function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
		_approve(msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
		return true;
	}

	/* Modifying functions */
	function _transfer(address sender, address recipient, uint256 amount) internal virtual {
		require(sender != address(0), "ERC20: transfer from the zero address");
		require(recipient != address(0), "ERC20: transfer to the zero address");

		_beforeTokenTransfer(sender, recipient, amount);

		_balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);

        emit Transfer(sender, recipient, amount);
	}

	// Mint when (need auth)
    function _mint(address account, uint256 amount) internal virtual isOwner {
        require(account != address(0), "ERC20: mint to the zero address");
        _beforeTokenTransfer(address(0), account, amount);
        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    // Burn when (need auth)
    function _burn(address account, uint256 amount) internal virtual isOwner {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /* Hooks */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { 
    }
}























