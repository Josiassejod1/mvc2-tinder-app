import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mvc2_card_game/api/api.dart';
import 'package:mvc2_card_game/controller/home_controller.dart';
import 'package:mvc2_card_game/models/character.dart';
import 'package:scratcher/widgets.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.isConnected && controller.isInOperatingChain) {
      controller.setBanner('You\'re connected!');
    } else if (controller.isConnected && !controller.isInOperatingChain) {
      controller.setBanner('Wrong chain! Please connect to Rinkeby. (4)');
    } else {
      controller.setBanner('Your browser is not supported!');
    }
    return Obx(() => Scaffold(
        appBar: AppBar(
          title: Text(controller.bannerDetail.value),
        ),
        body: FutureBuilder(
            future: Api.getCharacter('Akuma'),
            builder: (builder, snapshot) {
              final character = snapshot.data as Character;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(Ethereum.isSupported.toString()),
                    if (Ethereum.isSupported)
                      OutlinedButton(
                          child: Text('Connect'),
                          onPressed: controller.connectProvider),
                    if (snapshot.hasData)
                      Scratcher(
                        brushSize: 50,
                        threshold: 50,
                        color: Colors.grey,
                        onThreshold: () => {},
                        child: Image.network(
                          character.headShot!,
                          fit: BoxFit.fill,
                      ))
                  ],
                ),
              );
            }),
      ),
    );
  }
}
