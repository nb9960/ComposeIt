// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/// @title Crypto Composer Token
/// @author Nishtha Bodani
/// @notice ERC20 token to pay for minting ComposeIt NFT
contract ComposeItToken is ERC20, ERC20Burnable, AccessControl {
	bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

	constructor() ERC20("ComposeItToken", "CCT") {
		_grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
		_grantRole(MINTER_ROLE, msg.sender);
	}

	function decimals() public view virtual override returns (uint8) {
		return 0;
	}

	function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
		_mint(to, amount);
	}
}
