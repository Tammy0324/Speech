import 'package:flutter/material.dart';
import 'package:project/screens/exePage.dart';
import 'package:project/screens/home_page.dart';
import 'package:project/screens/new_audio.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}
class S {

 static S of(BuildContext context) => S.of(context);
 String get new_audio_microphone_permission_not_granted => "new_audio_microphone_permission_not_granted";
 String get new_audio_codec => "new_audio_codec";
 String get new_audio_codec_loading_error => "new_audio_codec_loading_error";
 String get new_audio_codec_loading => "new_audio_codec_loading";
 String get new_audio_AppBar => "new_audio_AppBar";
}


class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(title:'主頁'),
        '/audio': (context) => AudioSession(arIndex: (ModalRoute.of(context)!.settings.arguments as int)),
        '/new_audio': (context) => NewAudio(), // 錄放音功能畫面
      },
    );
  }
}



