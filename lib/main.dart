import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:project/screens/ariticlePage.dart';
import 'package:project/screens/dictionary.dart';
import 'package:project/screens/exePage.dart';
import 'package:project/screens/home1_page_screen.dart';
import 'package:project/screens/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project/generated/l10n.dart';
import 'package:project/screens/search_screen.dart';
import 'package:project/screens/showdic.dart';
import 'dart:async';

import 'package:project/screens/testexepage.dart';
import 'package:project/screens/welcome.dart';

void main() {
  runApp(ProviderScope(child:MyApp()));
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
        '/': (context) => WelcomePage(),
        //'/home': (context) => HomePage(title:'主頁'),
        '/home': (context) => Home1PageScreen(title:'主頁'),
        '/article': (context) => Article(),
        '/audio': (context) => AudioSession(arIndex: (ModalRoute.of(context)?.settings.arguments as int)),
        '/new_audio': (context) =>AudioSession1(arIndex: (ModalRoute.of(context)?.settings.arguments as int)),
        '/words': (context) => SearchScreen(),
        // '/new_audio': (context) => NewAudio(), // 錄放音功能畫面
      },
    );
  }
}



