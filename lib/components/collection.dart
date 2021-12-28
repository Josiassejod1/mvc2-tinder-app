import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc2_card_game/api/api.dart';
import 'package:mvc2_card_game/controller/contract_controller.dart';

class Collection extends StatelessWidget {
   final contractController = Get.put(ContractController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        contractController.getAllCharacterData(),
        Api.getAllCharacters(),
      ]),
      builder: (context, AsyncSnapshot<List> snapshot){
    //   if (snapshot.hasError){
        return Text('No collection found');
    //   } else {
    //     final allAddress = snapshot[0].,;
    //      final allCharacter = snapshot.data[1];
    //     return ListView(
    //   children: allAddress.map((e) => C),
    // )
      
    });
  }
}
