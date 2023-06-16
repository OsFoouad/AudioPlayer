// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:o_music/screens/musicHomeScreen.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "O Music",
      theme: ThemeData(
        fontFamily: "regularText",
        appBarTheme:
            AppBarTheme(elevation: 0, backgroundColor: Colors.transparent),
      ),
      home: OMusicHomePage(),
    );
  }
}
