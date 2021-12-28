import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mvc2_card_game/api/api.dart';
import 'package:mvc2_card_game/controller/contract_controller.dart';
import 'package:mvc2_card_game/controller/home_controller.dart';
import 'package:mvc2_card_game/models/character.dart';
import 'package:scratcher/widgets.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());
  final contractController = Get.put(ContractController());
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if ((controller.isConnected.value &&
              controller.isInOperatingChain.value)) {
        controller.setBanner('You\'re connected! $controller.currentAddress');
      } else if (controller.isConnected.value &&
          !controller.isInOperatingChain.value) {
        controller.setBanner('Wrong chain! Please connect to Rinkeby. (4)');
      } else {
        controller.setBanner('Wallet Not Connected');
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(controller.bannerDetail.value),
        ),
        body: FutureBuilder(
            future: Api.getCharacter('Akuma'),
            initialData: Character(
          headShot:
              "https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg",
          name: 'Unknown',
          universe: 'Uknown'),
            builder: (builder, snapshot) {
              final character = snapshot.data as Character;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Current Address: ' + controller.currentAddress.value),
                    Text('Current Address Empty: ' + controller.currentAddressEmpty.value.toString()),
                    Text('Current Current Address:' + controller.currentChain.value.toString()),
                    Text('Current Is Connected:' + controller.isConnected.toString()),
                    if (Ethereum.isSupported)
                      OutlinedButton(
                          child: Text('Connect'),
                          onPressed: () {
                            controller.connectProvider();
                            print('Test');
                          }),
                    if (snapshot.hasData)
                      Scratcher(
                          brushSize: 50,
                          threshold: 50,
                          color: Colors.grey,
                          onThreshold: () => {},
                          child: Image.network(
                            character.headShot!,
                            fit: BoxFit.fill,
                          )),
                    OutlinedButton(
                        child: Text('Mint'),
                        onPressed: () {
                          contractController.setCharacterData(character.name!);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Character Minted"),
                          ));
                        }),
                  ],
                ),
              );
            }),
      );
    });
  }
}
