//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart';
//import 'package:html/parser.dart' show parse;
//import 'package:project/http_service.dart';
//import 'package:project/posts.dart';
//import 'package:project/models/audio_rec.dart';

class AudioSession extends StatefulWidget {
  final int arIndex;

  // do we need key?
  AudioSession({Key? key, required this.arIndex}) : super(key: key);
  //AudioSession({required this.arIndex});

  @override
  _AudioSessionState createState() => _AudioSessionState();
}

class _AudioSessionState extends State<AudioSession> {
  int _selectedBottomBarItemIndex = 0;
  bool recordClick = true;
  bool playClick = true;

  void _onBottomBarItemTapped(int index) {
    setState(() {
      _selectedBottomBarItemIndex = index;
    });
  }

  var article = "\nThe teacher announces that there is a test. "; //範例文章
  IconData micicon = Icons.mic_outlined;
  AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    print("exe");
    return Scaffold(
        appBar: AppBar(
          title: Text("練習"),
          // automaticallyImplyLeading: false, // not display <- back btn
        ),
        // debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        //body: PostsPage(),
        bottomNavigationBar: Container(
          height: 110,
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.blueAccent,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      iconSize: 38,
                      color: Colors.white,
                      onPressed:play,
                      icon: const Icon( Icons.headphones_outlined),
                    ),
                  ),
                  Text(
                    'Play',
                    style: TextStyle(color: Colors.blueAccent.withOpacity(0.8)),
                  ),
                ],
              ),
              Column(
                children: [
                  Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.blueAccent,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      iconSize: 38,
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          recordClick = !recordClick;
                        });
                      },
                      icon: Icon((recordClick == false) ? Icons.stop : Icons.record_voice_over  ),
                    ),
                  ),
                  Text(
                    'Record',
                    style: TextStyle(color: Colors.blueAccent.withOpacity(0.8)),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
  void play() {
    print('Speech');
    player.play('voice/001/1.mp3');
  }
}