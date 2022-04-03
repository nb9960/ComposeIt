// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./ComposeItToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title Crypto Composer Token Vendor
/// @author Nishtha Bodani
/// @notice Manages supply and price of underlying CCT
contract ComposeItTokenVendor is ComposeItToken, Ownable {
	/// @notice Event emitted when user buys CCT
	/// @param by Address of user
	/// @param amount Amountn of CCT
	event CCTBought(address indexed by, uint256 amount);

	uint256 public tokenPrice = 10**(18 - 3); // 0.001 ETH

	/// @notice Update price of CCT
	/// @param _newPrice in ETH
	function setTokenPrice(uint256 _newPrice) external onlyOwner {
		tokenPrice = _newPrice;
	}

	address public ComposeItAddress;

	/// @notice Allow ComposeIt to receive CCT from users
	/// @param _addr address of ComposeIt contract
	function setComposeItAddress(address _addr) external onlyOwner {
		ComposeItAddress = _addr;
		_grantRole(MINTER_ROLE, _addr);
	}

	/// @notice Buy CCT
	/// @return tokenAmount The amount minted and transferred to sender
	function buyTokenToMintNFT()
		external
		payable
		returns (uint256 tokenAmount)
	{
		uint256 amountToBuy = msg.value / tokenPrice;
		require(amountToBuy > 0, "Send ETH to buy some tokens");

		require(ComposeItAddress != address(0));

		_mint(msg.sender, amountToBuy);
		increaseAllowance(ComposeItAddress, amountToBuy);

		emit CCTBought(msg.sender, amountToBuy);

		return amountToBuy;
	}

	/// @notice Withdraw whole balance and transfer it to the owner
	function withdrawAll() external onlyOwner {
		payable(owner()).transfer(address(this).balance);
	}
}
