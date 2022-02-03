import 'dart:convert';

import 'package:egovernance/Widgets/navigationDrawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Wallet extends StatefulWidget {
  static const String idScreen = "Wallet";
  @override
  _Wallet createState() => _Wallet();
}

class _Wallet extends State<Wallet> {
  int balance = 0, totalDeposits = 0, installmentAmount = 3;

  late Client httpClient;
  late Web3Client ethClient;
  // JSON-RPC is a remote procedure call protocol encoded in JSON
  // Remote Procedure Call (RPC) is about executing a block of code on another server
  String rpcUrl = 'HTTP://192.168.0.105:7545';

/*  @override
  void initState() {
    initialSetup();
    super.initState();
  }*/

  Future<void> initialSetup() async {
    /// This will start a client that connects to a JSON RPC API, available at RPC URL.
    /// The httpClient will be used to send requests to the [RPC server].
    httpClient = Client();

    /// It connects to an Ethereum [node] to send transactions, interact with smart contracts, and much more!
    ethClient = Web3Client(rpcUrl, httpClient);

    await getCredentials();
    await getDeployedContract();
    await getContractFunctions();
  }

  /// This will construct [credentials] with the provided [privateKey]
  /// and load the Ethereum address in [myAdderess] specified by these credentials.
  String privateKey =
      '20f5c5225ad22a3198ff507fc04e20385e863f5f7c707545b00d447cbe13d063';
  late Credentials _credentials;

  Credentials get credentials => _credentials;

  set credentials(Credentials credentials) {
    _credentials = credentials;
  }

  late EthereumAddress _myAddress;

  EthereumAddress get myAddress => _myAddress;

  set myAddress(EthereumAddress myAddress) {
    _myAddress = myAddress;
  }

  Future<void> getCredentials() async {
    credentials = await Future.value(EthPrivateKey.fromHex(privateKey));
    myAddress = await credentials.extractAddress();
  }

  /// This will parse an Ethereum address of the contract in [contractAddress]
  /// from the hexadecimal representation present inside the [ABI]
  late String abi;
  late EthereumAddress contractAddress;

  Future<void> getDeployedContract() async {
    String abiString = await rootBundle.loadString('src/abis/Investment.json');
    var abiJson = jsonDecode(abiString);
    abi = jsonEncode(abiJson['abi']);

    contractAddress =
        EthereumAddress.fromHex(abiJson['networks']['5777']['address']);
  }

  /// This will help us to find all the [public functions] defined by the [contract]
  late DeployedContract _contract;

  /// This will help us to find all the [public functions] defined by the [contract]
  DeployedContract get contract => _contract;

  /// This will help us to find all the [public functions] defined by the [contract]
  set contract(DeployedContract contract) {
    _contract = contract;
  }

  late ContractFunction getBalanceAmount,
      getDepositAmount = getDepositAmount,
      addDepositAmount = getBalanceAmount,
      withdrawBalance = getBalanceAmount;

  Future<void> getContractFunctions() async {
    contract = DeployedContract(
        ContractAbi.fromJson(abi, "Investment"), contractAddress);

    getBalanceAmount = contract.function('getBalanceAmount');
    getDepositAmount = contract.function('getDepositAmount');
    addDepositAmount = contract.function('addDepositAmount');
    withdrawBalance = contract.function('withdrawBalance');
  }

  /// This will call a [functionName] with [functionArgs] as parameters
  /// defined in the [contract] and returns its result
  Future<List<dynamic>> readContract(
    ContractFunction functionName,
    List<dynamic> functionArgs,
  ) async {
    var queryResult = await ethClient.call(
      contract: contract,
      function: functionName,
      params: functionArgs,
    );

    return queryResult;
  }

  /// Signs the given transaction using the keys supplied in the [credentials] object
  /// to upload it to the client so that it can be executed
  Future<void> writeContract(
    ContractFunction functionName,
    List<dynamic> functionArgs,
  ) async {
    await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: functionName,
        parameters: functionArgs,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Digi-Wallet'),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Colors.blueAccent],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Investments',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // show balance
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '₹ $balance',
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // update balance
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FloatingActionButton.extended(
                    heroTag: 'check_balance',
                    onPressed: () async {
                      var result = await readContract(getBalanceAmount, []);
                      balance = result.first.toInt();
                      setState(() {});
                    },
                    label: Text('Check Balance'),
                    icon: Icon(Icons.refresh),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              // show deposits
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '₹ $totalDeposits',
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // update deposits
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FloatingActionButton.extended(
                    heroTag: 'check_deposits',
                    onPressed: () async {
                      var result = await readContract(getDepositAmount, []);
                      totalDeposits = result.first.toInt();
                      setState(() {});
                    },
                    label: Text('Check Deposits'),
                    icon: Icon(Icons.refresh),
                    backgroundColor: Colors.black54,
                  ),
                ),
              ),
              // deposit amount
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 100,
                    width: 200,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: FloatingActionButton.extended(
                        heroTag: 'deposit_amount',
                        onPressed: () async {
                          await writeContract(addDepositAmount,
                              [BigInt.from(installmentAmount)]);
                        },
                        label: Text('Deposit ₹ 3'),
                        icon: Icon(Icons.add_circle),
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              // withdraw balance
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 70,
                    width: 200,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: FloatingActionButton.extended(
                        heroTag: 'withdraw_balance',
                        onPressed: () async {
                          await writeContract(withdrawBalance, []);
                        },
                        label: Text('Withdraw'),
                        icon: Icon(Icons.remove_circle),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ContractFunction>(
        'getBalanceAmount', getBalanceAmount));
  }
}
