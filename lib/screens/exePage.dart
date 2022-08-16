<<<<<<< Updated upstream
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../posts.dart';
=======
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../http_service.dart';
import 'dart:async';
import 'dart:io'; // use to get Platform info & check file exist, can't use on web
import 'dart:math';
import 'package:project/generated/l10n.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // only use kIsWeb
import 'package:project/shared/flutter_sound/flutter_sound_common.dart'; // the common part of flutter_sound
import 'package:project/shared/flutter_sound/flutter_sound_record.dart'; // the recording part of flutter_sound
import 'package:project/shared/flutter_sound/flutter_sound_play.dart'; // the player part of flutter_sound
import 'package:project/shared/flutter_sound/flutter_sound_audio_platform_base.dart';// 稻草人 scarecrow
import 'package:http/http.dart' as http;

/// Happy recorder - record audio into FILE only.
String _recorderTxt = '00:00:00'; // work for all language, no need to translate.
String _playerTxt = '00:00:00';
double? _dbLevel; // volume
bool? _encoderSupported = true; // Optimist, assuming Codec supported
bool _decoderSupported = true; // Optimist, assuming Codec supported
double? _duration; // Estimated audio length, uses FFmpeg, just an estimation, based on the Codec used and the sample rate.
Codec _codec = FSAudioPlatform().defaultCodec; /// codec default, set via flutter_sound_audio_platform_xxx, safari(MP4)/non-safari(WebM)/non-Web(pcm16WAV)

/// set the file name, later will allow user input
final String defaultFileName = "Audio";
>>>>>>> Stashed changes

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

  IconData micicon = Icons.mic_outlined;
  AudioPlayer player = AudioPlayer();

  int article_len = 0;

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
=======
    // Codec Selection
    Widget futureCodecSelect = FutureBuilder<List<Codec>>(
      future: _supportedCodec,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 5.0),
                  //   // child: Text(
                  //   //   S.of(context).new_audio_codec,
                  //   //   style: Theme.of(context).textTheme.bodyText2!
                  //   //       .apply(color: Theme.of(context).colorScheme.primary),
                  //   // ),
                  // ),
                  DropdownButton<Codec>(
                    value: _codec,
                    underline: Container(height: 0),
                    style: Theme.of(context).textTheme.bodyText2!
                        .apply(color: Theme.of(context).colorScheme.primary),
                    onChanged: (newCodec) {
                      setCodec(newCodec!);
                      _codec = newCodec;
                      getDuration();
                      setState(() {});
                    },
                    items: snapshot.data.map<DropdownMenuItem<Codec>>((item) {
                      return DropdownMenuItem<Codec>(
                        value: item,
                        child: Text("${ext[item.index].substring(1)}"),
                      );
                    }).toList(), // platform supported codec.
                  ),
                ],
              )
          );
        } else if (snapshot.hasError) {
          return Container(
              height: 50,
              // child: Center(
              //     child: Text(
              //       S.of(context).new_audio_codec_loading_error,
              //       style: Theme.of(context).textTheme.bodyText2!
              //           .apply(color: Theme.of(context).colorScheme.primary),
              //     )
              // )
          );
        } else {
          return Container(
              height: 50,
              // child: Center(
              //     child: Text(
              //       S.of(context).new_audio_codec_loading,
              //       style: Theme.of(context).textTheme.bodyText2!
              //           .apply(color: Theme.of(context).colorScheme.primaryVariant),
              //     )
              // )
          );
        }
      },
    );

    // Recorder
    Widget recorderSection = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Container(
          //   margin: const EdgeInsets.only(top: 12.0, bottom: 3.0),
          //   child: Text(
          //     _recorderTxt,
          //     style: Theme.of(context).textTheme.headline5!
          //         .apply(color: Theme.of(context).colorScheme.primary),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 3.0, bottom: 6.0),
            child: Text(
              _recMsg,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          (_isRecording && !kIsWeb) /// Flutter_sound not support web recording volume
              ? Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary)),
              child: LinearProgressIndicator(
                  minHeight: 10.0,
                  value: 1.0 / 120.0 * (_dbLevel ?? 1), // _dbLevel ranges from 0 to 120, ?? = if null
                  valueColor: AlwaysStoppedAnimation<Color>( Theme.of(context).colorScheme.primary),
                  backgroundColor: Theme.of(context).colorScheme.background))
              : Container(margin: EdgeInsets.only(top: 12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 56.0,
                height: 50.0,
                child: ClipOval(
                  child: TextButton(
                    onPressed: onStartRecorderPressed(),
                    child: recorderIcon(),
                  ),
                ),
              ),
              Container(
                width: 56.0,
                height: 50.0,
                child: ClipOval(
                  child: TextButton(
                      onPressed: onPauseResumeRecorderPressed(), // null = disable
                      child: onPauseResumeRecorderPressed() != null
                          ? (recorderModule.isPaused
                          ? Icon(Icons.arrow_right_outlined,size: 38)
                          : Icon(Icons.pause_outlined,size: 38))
                          : Container()),
                ),
              ),
            ],
          ),
        ]);

    // Player
    Widget playerSection = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Container(
        //   margin: const EdgeInsets.only(top: 12.0, bottom: 16.0),
        //   child: Text(
        //     _playerTxt,
        //     style: Theme.of(context).textTheme.headline5!.apply(color: Theme.of(context).colorScheme.primary),
        //   ),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 56.0,
              height: 50.0,
              child: ClipOval(
                child: TextButton(
                    onPressed: onStartPauseResumePlayerPressed(),
                    child: (playerModule.isStopped || playerModule.isPaused)
                        ? Icon(Icons.play_arrow_outlined,size: 38)
                        : Icon(Icons.pause_outlined,size: 38)),
              ),
            ),
            Container(
              width: 56.0,
              height: 50.0,
              child: ClipOval(
                child: TextButton(
                    onPressed: onStopPlayerPressed(),
                    child: (playerModule.isPlaying || playerModule.isPaused)
                        ? Icon(Icons.stop_outlined,size: 38)
                        : Container()),
              ),
            ),
          ],
        ),
        Container(
            height: 30.0,
            child: Slider(
                value: min(fsSliderCurrentPosition, fsMaxDuration),
                min: 0.0,
                max: fsMaxDuration,
                onChanged: (value) async {
                  await seekToPlayer(value.toInt());
                },
                divisions: fsMaxDuration == 0.0 ? 1 : fsMaxDuration.toInt())),
        // Container(
        //   height: 30.0,
        //   child: Text('null'),
        //   // child: Text(_duration != null ? S.of(context).new_audio_duration( new NumberFormat.compact().format(_duration)) : ''),
        // ),
      ],
    );

    final Connect httpService = Connect();

>>>>>>> Stashed changes
    return Scaffold(
        appBar: AppBar(
          title: Text("練習"),
          // automaticallyImplyLeading: false, // not display <- back btn
        ),
<<<<<<< Updated upstream
        // debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        body: PostsPage(),
=======
        body: FutureBuilder(
          future: httpService.getPosts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<String> posts = snapshot.data;
              article_len = posts.length-2;
              return Center(
                  child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (BuildContext context, int num) {
                        var sen = posts[num];
                        return Center(
                          child: Text(
                            sen,
                            style: TextStyle(fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                  )
              );
            } else {
              return Center(child: Text("No Data."));
            }
          },
        ),
>>>>>>> Stashed changes
        bottomNavigationBar: Container(
          height: 110,
          padding: const EdgeInsets.only(top: 10.0),
<<<<<<< Updated upstream
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
=======
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Column(// player
                    children: [
                      Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          iconSize: 38,
                          color: Colors.blueAccent,
                          onPressed: previous,
                          icon: const Icon( Icons.skip_previous),
                        ),
                      ),
                      Text(
                        'Previous',
                        style: TextStyle(color: Colors.blueAccent.withOpacity(0.8)),
                      ),
                    ],
>>>>>>> Stashed changes
                  ),
                  Column(// player
                    children: [
                      Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          iconSize: 38,
                          color: Colors.blueAccent,
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
                  Column(// player
                    children: [
                      Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          iconSize: 38,
                          color: Colors.blueAccent,
                          onPressed:next,
                          icon: const Icon( Icons.skip_next),
                        ),
                      ),
                      Text(
                        'Next',
                        style: TextStyle(color: Colors.blueAccent.withOpacity(0.8)),
                      ),
                    ],
                  ),
                ],
              ),
<<<<<<< Updated upstream
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
=======
              Row(
                  children: [
                    Column( //Recorder
                      children: [
                        kIsWeb ? Container() : futureCodecSelect,
                        recorderSection, // recording
                      ],
                    ),
                    Column( //Record Player
                      children: [
                        kIsWeb ? Container() : futureCodecSelect,
                        playerSection, // recordPlayer
                      ],
                    ),
                  ]
              ),
              Row(
                children: [
                  IconButton(
                    iconSize: 38,
                    color: Colors.blueAccent,
                    onPressed: _uploadFile,
                    icon: const Icon( Icons.publish),
>>>>>>> Stashed changes
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
<<<<<<< Updated upstream
  void play() {
    print('Speech');
    player.play('voice/001/5.mp3');
=======

  int sen_num = 1;

  previous() {
    print('previous');
    if(sen_num <= 1) {
      Fluttertoast.showToast(msg: '沒有上一句了！');
    } else {
      sen_num -= 1;
      print("sen_num = $sen_num");
    }
  }

  next() {
    print('next');
    if(sen_num >= article_len) {
      Fluttertoast.showToast(msg: '沒有下一句了！');
    } else {
      sen_num += 1;
      print("sen_num = $sen_num");
    }
  }

  Future<void> play() async {
    print('Speech $sen_num');
    // player.play('voice/001/5.mp3');

    final url = 'http://172.20.10.10:8000/example/$sen_num';
    DownloadService downloadService =
    kIsWeb ? WebDownloadService() : MobileDownloadService();
    await downloadService.download(url: url);

    Dio dio = Dio();
    var dir = await getApplicationDocumentsDirectory();
    String fileName = 'example';
    player.play('${dir.path}/$fileName');
>>>>>>> Stashed changes
  }

  List<PlatformFile>? _files;

  void _uploadFile() async {
    //TODO replace the url bellow with you ipv4 address in ipconfig
    var uri = Uri.parse('http://172.20.10.10:8000/');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath(
        'file', _files!.first.path.toString()));
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Uploaded ...');
    } else {
      print('Something went wrong!');
    }
  }
}