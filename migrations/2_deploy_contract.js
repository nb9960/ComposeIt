const CCTVendor = artifacts.require('./ComposeItTokenVendor.sol');
const ComposeIt = artifacts.require('./ComposeIt.sol');

module.exports = async function (deployer) {
  // Use deployer to state migration tasks.
  await deployer.deploy(CCTVendor);
  const cctInstance = await CCTVendor.deployed();

  await deployer.deploy(ComposeIt, cctInstance.address);
  const composerInstance = await ComposeIt.deployed();

  await cctInstance.setComposeItAddress(composerInstance.address);
};
