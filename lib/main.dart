import 'package:flutter/material.dart';
import 'package:project/screens/ariticlePage.dart';
import 'package:project/screens/exePage.dart';
import 'package:project/screens/home_page.dart';
import 'package:project/screens/new_audio.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project/generated/l10n.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      title: 'Home',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,

      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(title:'主頁'),
        '/article': (context) => Article(),
        '/audio': (context) => AudioSession(arIndex: (ModalRoute.of(context)!.settings.arguments as int)),
        '/new_audio': (context) => NewAudio(), // 錄放音功能畫面
      },
    );
  }
}



