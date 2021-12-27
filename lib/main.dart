import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mvc2_card_game/components/collection.dart';
import 'package:mvc2_card_game/controller/home_controller.dart';

import 'components/home.dart';

void main() {
  runApp(const MyApp());
}

void onInit() {
  final controller = Get.put(HomeController());
  controller.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'MVC2 Trading Card',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: HomePage(),
      getPages: [
        GetPage(name: '/collection', page: () => Collection()),
      ],
    );
  }
}
