module.exports = {
  networks: {
    development: {
      host: "192.168.0.105",
      port: 7545,
      network_id: "5777", // Match any network id
    },
  },
  contracts_build_directory: "./src/abis/",
  compilers: {
    solc: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
