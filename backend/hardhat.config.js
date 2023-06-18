module.exports = {
  solidity: {
    version: '0.8.9',
    networks: {
      Edgeware: {
        url: 'https://edgeware-evm.jelliedowl.net',
        chainId: 2021,
        accounts: [`0x${process.env.PRIVATE_KEY}`]
      },
      Beresheet: {
        url: 'https://beresheet-evm.jelliedowl.net',
        chainId: 2022,
        accounts: [`0x${process.env.PRIVATE_KEY}`]
      },
      hardhat: {}
    },
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
