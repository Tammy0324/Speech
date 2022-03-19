import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/exePage.dart';
import 'package:project/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      title: '主頁',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(title: '主頁'),
        '/audio': (context) => AudioSession(arIndex: (ModalRoute.of(context)!.settings.arguments as int)),
      },
    );
  }
}
