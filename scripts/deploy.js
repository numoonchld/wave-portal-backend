const main = async () => {
  const [deployer] = await hre.ethers.getSigners()
  const accountBalance = await deployer.getBalance()

  console.log("Account deploying contracts: ", deployer.address)
  console.log("Account balance: ", accountBalance.toString())

  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal")
  const waveContract = await waveContractFactory.deploy()
  await waveContract.deployed()

  console.log("WavePortal address: ", waveContract.address)
}

const runMain = async () => {
  try {
    await main()
    process.exit(0)
  }
  catch (error) {
    console.error(error)
    process.exit(1)
  }
}

runMain()