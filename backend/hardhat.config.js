module.exports = {
  solidity: {
    version: '0.8.9',
    networks: {
      Filecoin: {
        url: 'https://rpc.ankr.com/filecoin',
        chainId: 314,
        accounts: [`0x${process.env.PRIVATE_KEY}`]
      },
      Calibration: {
        url: 'https://filecoin-calibration.chainstacklabs.com/rpc/v1',
        chainId: 314159,
        accounts: [`0x${process.env.PRIVATE_KEY}`]
      },
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
