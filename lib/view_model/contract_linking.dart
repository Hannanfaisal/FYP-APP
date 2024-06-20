import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking with ChangeNotifier {

  final String _rpcUrl =
    'http://192.168.100.26:7545';
  final String _wsUrl = 'http://192.168.100.26:7545';
  // final String _rpcUrl=
  // Platform.isAndroid ? 'http://10.0.2.2:7545' : 'http://0.0.0.0:7545';
  // final String _wsUrl = Platform.isAndroid ? 'http://10.0.2.2:7545' : 'ws://0.0.0.0:7545';
  final String _privateKey =
      '0x356943a0f6b475ee82a18103ad7f3a7d89bfe9c7e184f1ecdb87d758b13c064f';

  Web3Client? _web3client;
  bool isLoading = true;
  String? _abiCode;
  EthereumAddress? _contractAddress;
  Credentials? _credentials;
  DeployedContract? _contract;
  ContractFunction? _message;
  ContractFunction? _setMessage;

  String? deployedName;

  ContractLinking() {
    setup();
  }

  setup() async {
    _web3client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

   // _web3client = Web3Client(_rpcUrl, Client());

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString('build/contracts/HelloWorld.json');
    final jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);


    _contractAddress =
        EthereumAddress.fromHex(jsonAbi['networks']['5777']['address']);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "HelloWorld"), _contractAddress!);

    _message = _contract!.function("message");
    _setMessage = _contract!.function("setMessage");
    getMessage();
  }

  getMessage() async {
    final _mymessage = await _web3client!
        .call(contract: _contract!, function: _message!, params: []);

    deployedName = _mymessage[0];
    isLoading = false;
    notifyListeners();
  }

  setMessage(String message) async {
    isLoading = true;
    notifyListeners();
    await _web3client!.sendTransaction(
        _credentials!,
        Transaction.callContract(
            contract: _contract!,
            function: _setMessage!,
            parameters: [message]), chainId: 1337,
        fetchChainIdFromNetworkId: false);

    getMessage();
  }
}
