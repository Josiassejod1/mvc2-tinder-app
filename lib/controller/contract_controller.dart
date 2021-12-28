import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class ContractController extends GetxController {
  Rx<ContractCharacter> get character => _character.obs;
  final String blockChainUrl = dotenv.env['ALCHEMY_API_LINK']!;
  final String ethAddress = dotenv.env['MY_ADDRESS']!;

  final httpClient = Client();

  ContractCharacter _character = ContractCharacter("Akuma", "like");

  Future<DeployedContract> getContract() async {
    String abiFile = await rootBundle.loadString("assets/contract.json");
    String contractAddress = dotenv.env['CONTRACT_ADDRESS']!;

    final contract = DeployedContract(
        ContractAbi.fromJson(abiFile, "Character"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> callFunction(
      String name, Web3Client client, List<dynamic> params) async {
    final contract = await getContract();
    final function = contract.function(name);
    return await client.call(
        contract: contract, function: function, params: params);
  }

  Web3Client getClient() {
    return Web3Client(
      blockChainUrl,
      httpClient,
    );
  }

  Future<List<ContractCharacter>> getAllCharacterData() async {
    return callFunction("getAllCharacterData", getClient(), [])
        as List<ContractCharacter>;
  }

  Future<void> setCharacterData(String name) async {
    Credentials key = EthPrivateKey.fromHex(dotenv.env['PRIVATE_KEY']!);
    final contract = await getContract();
    final function = contract.function(
      "setCharacterData",
    );

    Web3Client ethClient = getClient();

    await ethClient.sendTransaction(
        key,
        Transaction.callContract(
            contract: contract, function: function, parameters: [name, "like"]),
        chainId: 4);
  }
}

class ContractCharacter {
  final String name;
  final String? rating;

  ContractCharacter(this.name, this.rating);
}
