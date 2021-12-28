import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {
  RxBool get isInOperatingChain => (currentChain == OPERATING_CHAIN).obs;

  RxBool get isConnected => (isSupported.value && currentAddressEmpty.value).obs;

  RxBool get isSupported => Ethereum.isSupported.obs;
  RxBool get currentAddressEmpty => currentAddress.isNotEmpty.obs;
  RxString get currentAddress => _currentAddress.obs;

  String _banner = '';
  String _currentAddress = '';
  Rx<String> get bannerDetail => _banner.obs;
  int _currentChain = -1;

  setBanner(String text) {
    _banner = text;
    bannerDetail.refresh();
  }
 
  RxInt get currentChain => _currentChain.obs;

  bool wcConnected = false;

  static const OPERATING_CHAIN = 4;

  final wc = WalletConnectProvider.fromRpc(
        {4: dotenv.env['ALCHEMY_API_LINK']!},
        chainId: 4,
        network: 'rinkeby',
      );

  Rx<Web3Provider>? web3wc = null;

  connectProvider() async {
    if (Ethereum.isSupported) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) {
        try {
          _currentAddress = accs.first;
          _currentChain = await ethereum!.getChainId();
          currentChain.refresh();
          currentAddress.refresh();
         inspect(_currentChain);
        } on EthereumUserRejected {
           ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
                            content: Text("Character Minted"),
                          ));
        }
      } 

      update();
    }
  }

  connectWC() async {
    if (wc.connected) {
      _currentAddress = wc.accounts.first;
      _currentChain = 4;
      wcConnected = true;
      web3wc = Web3Provider.fromEthereum(ethereum!).obs;
    }

    update();
  }

  clear() {
    _currentAddress = '';
    _currentChain = -1;
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
    final rpcProvider = JsonRpcProvider(dotenv.env['ALCHEMY_API_LINK']!);
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