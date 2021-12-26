import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mvc2_card_game/api/api.dart';
import 'package:mvc2_card_game/controller/home_controller.dart';
import 'package:mvc2_card_game/models/character.dart';
import 'package:playing_cards/playing_cards.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomePage({Key? key}) : super(key: key);

  @override
  void onInit() {
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    var shown = '';
    if (controller.isConnected && controller.isInOperatingChain)
      shown = 'You\'re connected!';
    else if (controller.isConnected && !controller.isInOperatingChain)
      shown = 'Wrong chain! Please connect to BSC. (56)';
    else if (Ethereum.isSupported)
      return OutlinedButton(
          child: Text('Connect'), onPressed: controller.connectProvider);
    else
      shown = 'Your browser is not supported!';

    return Scaffold(
      appBar: AppBar(
        title: Text(shown),
      ),
      body: FutureBuilder(
          future: Api.getCharacter('Akuma'),
          builder: (builder, snapshot) {
            final character = snapshot.data as Character;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (snapshot.hasData)
                    Container(
                      height: 550,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(
                            (character.headShot!),
                            scale: .5,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            );
          }),
    );
  }
}
