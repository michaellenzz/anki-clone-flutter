import 'package:anki_clone/controllers/card_controller.dart';
import 'package:anki_clone/database/sqflite.dart';
import 'package:anki_clone/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SQFlite sqFlite = SQFlite();
    sqFlite.getCartao(2).then((value) {
      //print(value!.frontImage);
      ;
    });
    return GetMaterialApp(
        title: 'Anki Clone',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage());
  }
}
