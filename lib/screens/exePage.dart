import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound/flutter_sound.dart';
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

  void _onBottomBarItemTapped(int index) {
    setState(() {
      _selectedBottomBarItemIndex = index;
    });
  }

  var article = "The teacher announces that there is a test. "; //範例文章
  IconData micicon = Icons.mic_outlined;
  AudioPlayer player = AudioPlayer();

  FlutterSound flutterSound = new FlutterSound();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("練習"),
          // automaticallyImplyLeading: false, // not display <- back btn
        ),
        body: Container(
          child: Text(article),
        ),
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
                      icon: const Icon(Icons.headphones_outlined),
                      iconSize: 38,
                      color: Colors.white,
                      onPressed: play,
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
                      icon: const Icon(Icons.record_voice_over),
                      iconSize: 38,
                      color: Colors.white,
                      onPressed: () {
                        _onBottomBarItemTapped(1);
                      },
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
    player.play('voice/example.mp3');
  }
}