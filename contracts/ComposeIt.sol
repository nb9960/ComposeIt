// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./ComposeItTokenVendor.sol";
import "./ComposeItNFTMinter.sol";

/// @title Contract to mint music NFT with ComposeItToken
/// @author Nishtha Bodani
/// @notice Allows users to mint their song, accepting CCT as payment
contract ComposeIt is ComposeItNFTMinter {
	ComposeItTokenVendor tokenVendor;

	constructor(address cctAddress) {
		tokenVendor = ComposeItTokenVendor(cctAddress);
	}

	uint256 public tokenPerMinting = 1;

	modifier hasEnoughComposerToken() {
		uint256 allowance = tokenVendor.allowance(msg.sender, address(this));
		require(allowance >= tokenPerMinting, "Check the token allowance");
		_;
	}

	/// @notice Mint a new NFT if the caller sends enough CCT
	/// @param title title of the song
	/// @param notes data representing the music
	function mintNewSong(string calldata title, bytes calldata notes)
		external
		hasEnoughComposerToken
		returns (uint256)
	{
		bool sent = tokenVendor.transferFrom(
			msg.sender,
			address(this),
			tokenPerMinting
		);
		require(sent, "Failed to pay token to contract");

		return _mintNewSong(title, notes);
	}
}
