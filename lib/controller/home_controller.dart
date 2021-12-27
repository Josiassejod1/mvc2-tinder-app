import 'dart:developer';

import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {
  bool get isInOperatingChain => currentChain == OPERATING_CHAIN;

  bool get isConnected => Ethereum.isSupported && currentAddress.isNotEmpty;

  String _banner = '';
  Rx<String> get bannerDetail => _banner.obs;

  setBanner(String text) {
    _banner = text;
  }

  getRandomCharacter() {

  }
  String currentAddress = '';

  int currentChain = -1;

  bool wcConnected = false;

  static const OPERATING_CHAIN = 4;

  final wc = WalletConnectProvider.fromRpc(
        {4: 'https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161'},
        chainId: 4,
        network: 'rinkeby',
      );

  Web3Provider? web3wc;

  connectProvider() async {
    if (Ethereum.isSupported) {
      print("wtf");
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) {
          print("dang");
        currentAddress = accs.first;
        currentChain = await ethereum!.getChainId();
        inspect(currentChain);
      }

      update();
    }
  }

  connectWC() async {
    await wc.connect();
    if (wc.connected) {
      currentAddress = wc.accounts.first;
      currentChain = 4;
      wcConnected = true;
      web3wc = Web3Provider.fromWalletConnect(wc);
    }

    update();
  }

  clear() {
    currentAddress = '';
    currentChain = -1;
    wcConnected = false;
    web3wc = null;

    update();
  }

  init() {
    if (Ethereum.isSupported) {
      connectProvider();

      ethereum!.onAccountsChanged((accs) {
        clear();
      });

      ethereum!.onChainChanged((chain) {
        clear();
      });
    }
  }

  getLastestBlock() async {
    print(await provider!.getLastestBlock());
    print(await provider!.getLastestBlockWithTransaction());
  }

  testProvider() async {
    final rpcProvider = JsonRpcProvider('https://rinkeby.etherscan.io/');
    print(rpcProvider);
    print(await rpcProvider.getNetwork());
  }

  test() async {}


  @override
  void onInit() {
    init();

    super.onInit();
  }
}