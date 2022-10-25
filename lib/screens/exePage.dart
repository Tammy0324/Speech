import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
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
Codec _codec = Codec.pcm16WAV; /// codec default, set via flutter_sound_audio_platform_xxx, safari(MP4)/non-safari(WebM)/non-Web(pcm16WAV)

/// set the file name, later will allow user input
const String defaultFileName = "Audio";

class AudioSession extends StatefulWidget {
  final int arIndex;

  // do we need key?
  AudioSession({Key? key, required this.arIndex}) : super(key: key);
  //AudioSession({required this.arIndex});

  @override
  _AudioSessionState createState() => _AudioSessionState();
}

class _AudioSessionState extends State<AudioSession> {
  GlobalKey<_RefreshState> RecordingKey = GlobalKey(); //監聽
  int sen_num = 1;
  int _selectedBottomBarItemIndex = 0;
  bool recordClick = true;
  bool playClick = true;
  bool recordPlayerClick = true;

  bool _isRecording = false; // initial recording status to not recording.
  String? _path; // file path name, not explicitly initialized = null.
  String _recMsg = ""; // recoding message or audio file name.


  // initial
  Future<void> init() async {
    await fsInitializeRecorder();
    await fsInitializePlayer(false);
    //await setCodec(_codec);
    //_supportedCodec = platformSupportedCodec(); // Supported Codecs list, a future
  }//end of init

  void startRecorder() async {
    var _startRecorderErr = false; // error indicator

    try {
      // Request Microphone permission,
      // also need to add 'PERMISSION_MICROPHONE=1' at PodFile & uses-permission at AndroidManifest
      if (!kIsWeb) {
        var status = await Permission.microphone.request();
        if (status != PermissionStatus.granted) {
          throw RecordingPermissionException(
              S.of(context).new_audio_microphone_permission_not_granted);
        }
      }
      var path = "";
      _recMsg = '$defaultFileName$sen_num${ext[_codec.index]}'; // recoding message = file name
      if (!kIsWeb) {
        var tempDir = await getExternalStorageDirectory();  // need path_provider package
        path = '${tempDir?.path}/$_recMsg';
      } else {
        path = '_$_recMsg';
      }

      // start recording, api: https://tau.canardoux.xyz/tau_api_recorder_start_recorder.html
      await recorderModule.startRecorder(
        toFile: path,
        codec: _codec,
        bitRate: 16384, /// is K bit/s? aac sample rate 16k need 16K bit rate, 8k bit rate can do only 8000 sample rate.
        numChannels: 1,
        sampleRate: (_codec == Codec.pcm16) ? fsSAMPLERATE : fsSAMPLERATE_Low, /// non PCM canNOT use 44100, use lower sample rate 16000
      );
      recorderModule.logger.d('startRecorder');

      // onProgress is a stream to post recorder status. api: https://tau.canardoux.xyz/tau_api_recorder_on_progress.html
      fsRecorderSubscription = recorderModule.onProgress!.listen((e) {
        var date = DateTime.fromMillisecondsSinceEpoch(
            e.duration.inMilliseconds,
            isUtc: true);
        _dbLevel = e.decibels;
      });
      _isRecording = true;
      _path = path;
      RecordingKey.currentState?.onPressed(_isRecording);

      // setState(() { //按下錄音鍵
      //   print("125");
      //   _isRecording = true;
      //   _path = path;
      // });
    } on RecordingPermissionException catch (err_inst) {
      _startRecorderErr = true;
      recorderModule.logger.e('RecordingPermissionException error:' + err_inst.message);
      _recMsg = err_inst.message;
    } catch (err, s) {
      // all other error
      _startRecorderErr = true;
      recorderModule.logger.e('startRecorder error: $err, stack: $s');
      _recMsg = err.toString();
    } finally {
      if (_startRecorderErr) {
        setState(() {
          stopRecorder();
          _isRecording = false;
          fsCancelRecorderSubscriptions();
        });
      }
    }
  }//end of startRecorder

  // get audio duration: (Web not work, its _duration = null)
  // Future<void> getDuration() async {
  //   var path = _path;
  //   var d = path != null ? await flutterSoundHelper.duration(path) : null;
  //   _duration = d != null ? d.inMilliseconds / 1000.0 : null;
  //   setState(() {
  //     print("156");
  //   });
  // }// end of getDuration

  void stopRecorder() async {
    try {
      await recorderModule.stopRecorder();
      recorderModule.logger.d('stopRecorder');
      fsCancelRecorderSubscriptions();
      //await getDuration();
    } on Exception catch (err) {
      recorderModule.logger.d('stopRecorder error: $err');
    }
    _isRecording = false;
    RecordingKey.currentState?.onPressed(_isRecording);
    //局部刷新！！！
    // setState(() { //按下錄音結束鍵
    //   print("170");
    //   _isRecording = false;
    // });
  }//end of stopRecorder

  void pauseResumeRecorder() async {
    try {
      if (recorderModule.isPaused) {
        await recorderModule.resumeRecorder();
      } else {
        await recorderModule.pauseRecorder();
        assert(recorderModule.isPaused);
      }
    } on Exception catch (err) {
      recorderModule.logger.e('error: $err');
    }
    setState(() {});
  }//end of pauseResumeRecorder

  void Function()? onPauseResumeRecorderPressed() {
    if (recorderModule.isPaused || recorderModule.isRecording) {
      return pauseResumeRecorder;
    }
    return null;
  }//end of onPauseResumeRecorderPressed

  void startStopRecorder() {
    if (recorderModule.isRecording || recorderModule.isPaused) {
      stopRecorder();
    } else {
      startRecorder();
    }
  }//end of startStopRecorder

  void Function()? onStartRecorderPressed() {
    if (!_encoderSupported!) return null; // null: disable the button when selected codec not supported
    return startStopRecorder;
  }//end of onStartRecorderPressed

  // Future<void> setCodec(Codec codec) async {
  //   _encoderSupported = await recorderModule.isEncoderSupported(codec);
  //   _decoderSupported = await playerModule.isDecoderSupported(codec);
  //   setState(() {
  //     _codec = codec;
  //   });
  // }//end of setCodec

  /// record player
  void _addListeners() {
    fsCancelPlayerSubscriptions();
    fsPlayerSubscription = playerModule.onProgress!.listen((e) {
      fsMaxDuration = e.duration.inMilliseconds.toDouble();
      if (fsMaxDuration <= 0) fsMaxDuration = 0.0;

      fsSliderCurrentPosition =
          min(e.position.inMilliseconds.toDouble(), fsMaxDuration);
      if (fsSliderCurrentPosition < 0.0) {
        fsSliderCurrentPosition = 0.0;
      }

      var date = DateTime.fromMillisecondsSinceEpoch(e.position.inMilliseconds,
          isUtc: true);
      // setState(() { //播放錄音內容
      //   print("246");
      // });
    });
  }//end o _addListeners

  Future<void> startPlayer() async {
    try {
      String? audioFilePath;

      if (kIsWeb || await File(_path!).exists() ) { // if not web, check file exists?
        audioFilePath = _path;
        print(audioFilePath);
      }

      if (audioFilePath != null) {
        await playerModule.startPlayer(
            fromURI: audioFilePath, // play a file or a remote URI (just put the url in)
            codec: _codec,
            sampleRate: fsSAMPLERATE,
            whenFinished: () {
              playerModule.logger.d('Play finished');
              setState(() {});
            });

        _addListeners();
        setState(() {});
        playerModule.logger.d('<--- startPlayer');
      }
    } on Exception catch (err) {
      playerModule.logger.e('error: $err');
    }
  }//end of startPlayer

  Future<void> stopPlayer() async {
    try {
      await playerModule.stopPlayer();
      playerModule.logger.d('stopPlayer');
      if (fsPlayerSubscription != null) {
        await fsPlayerSubscription!.cancel();
        fsPlayerSubscription = null;
      }
      fsSliderCurrentPosition = 0.0;
    } on Exception catch (err) {
      playerModule.logger.d('error: $err');
    }
    setState(() {});
  }//end of stopPlayer

  void pauseResumePlayer() async {
    try {
      if (playerModule.isPlaying) {
        await playerModule.pausePlayer();
      } else {
        await playerModule.resumePlayer();
      }
    } on Exception catch (err) {
      playerModule.logger.e('error: $err');
    }
    setState(() {});
  }// end of pauseResumePlayer

  /// start/pause/resume Player 3-in-1
  void Function()? onStartPauseResumePlayerPressed() {
    if (_path == null) return null; // no file, not able play, disable btn
    // selected codec is not supported, disable btn
    /// why force Codec.pcm16 always = enabled?
    if (!(_decoderSupported || _codec == Codec.pcm16)) return null;
    if (playerModule.isStopped) return startPlayer;
    if (playerModule.isPaused || playerModule.isPlaying) return pauseResumePlayer;

    return null; // catch all, just disable btn
  }//end of onStartPauseResumePlayerPressed

  void Function()? onStopPlayerPressed() {
    return (playerModule.isPlaying || playerModule.isPaused)
        ? stopPlayer
        : null;
  }//end of onStopPlayerPressed

  Future<void> seekToPlayer(int milliSecs) async {
    try {
      if (playerModule.isPlaying) {
        await playerModule.seekToPlayer(Duration(milliseconds: milliSecs));
      }
    } on Exception catch (err) {
      playerModule.logger.e('error: $err');
    }
    setState(() {});
  }//end of seekToPlayer

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    fsCancelPlayerSubscriptions();
    fsCancelRecorderSubscriptions();
    fsReleaseFlutterSoundRecorderSession();
    fsReleaseFlutterSoundPlayerSession();
  }

  AudioPlayer player = AudioPlayer();

  int article_len = 0;

  @override
  Widget build(BuildContext context) {
    // Codec Selection
    // Widget futureCodecSelect = FutureBuilder<List<Codec>>(
    //   //future: _supportedCodec,
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.hasData) {
    //       return Container(
    //           height: 50,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             crossAxisAlignment: CrossAxisAlignment.end,
    //             children: <Widget>[
    //               DropdownButton<Codec>(
    //                 value: _codec,
    //                 underline: Container(height: 0),
    //                 style: Theme
    //                     .of(context)
    //                     .textTheme
    //                     .bodyText2!
    //                     .apply(color: Theme
    //                     .of(context)
    //                     .colorScheme
    //                     .primary),
    //                 onChanged: (newCodec) {
    //                   setCodec(newCodec!);
    //                   _codec = newCodec;
    //                   getDuration();
    //                 },
    //                 items: snapshot.data.map<DropdownMenuItem<Codec>>((item) {
    //                   return DropdownMenuItem<Codec>(
    //                     value: item,
    //                     child: Text("${ext[item.index].substring(1)}"),
    //                   );
    //                 }).toList(), // platform supported codec.
    //               ),
    //             ],
    //           )
    //       );
    //     } else {
    //       return Container(
    //         height: 50,
    //       );
    //     }
    //   },
    // );

    // Recorder
    Widget recorderSection = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
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
                    child: Refresh(RecordingKey),
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
      ],
    );

    final Connect httpService = Connect();

    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          // automaticallyImplyLeading: false, // not display <- back btn
        ),
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
        bottomNavigationBar: Container(
          height: 500,
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
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
              const SizedBox(
                height: 50,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column( //Recorder
                      children: [
                        //kIsWeb ? Container() : futureCodecSelect,
                        recorderSection, // recording
                      ],
                    ),
                    Column( //Record Player
                      children: [
                        //kIsWeb ? Container() : futureCodecSelect,
                        playerSection, // recordPlayer
                      ],
                    ),
                    IconButton(
                      iconSize: 38,
                      color: Colors.blueAccent,
                      onPressed: _uploadFile,
                      icon: const Icon(Icons.publish),
                    ),
                  ]
              ),
            ],
          ),
        )
    );
  }

  previous() {
    print('previous');
    if (sen_num <= 1) {
      Fluttertoast.showToast(msg: '沒有上一句了！');
    } else {
      sen_num -= 1;
      print("sen_num = $sen_num");
    }
    play();
  }

  next() {
    print('next');
    if (sen_num >= article_len) {
      Fluttertoast.showToast(msg: '沒有下一句了！');
    } else {
      sen_num += 1;
      print("sen_num = $sen_num");
    }
    play();
  }

  Future<void> play() async {
    print('Speech $sen_num');

    final url = 'http://172.20.10.10:8000/example/$sen_num';
    DownloadService downloadService =
    kIsWeb ? WebDownloadService() : MobileDownloadService();
    await downloadService.download(url: url);

    Dio dio = Dio();
    var dir = await getApplicationDocumentsDirectory();
    String fileName = 'example';
    player.play('${dir.path}/$fileName');
  }


  void _uploadFile() async {
    //TODO replace the url bellow with you ipv4 address in ipconfig
    var uri = Uri.parse('http://172.20.10.10:8000/recorder/$sen_num');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath(
        'file', '/storage/emulated/0/Android/data/com.example.project/files/Audio$sen_num${ext[_codec.index]}'));
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Uploaded ...');
    } else {
      print('Something went wrong!');
    }
  }
}

//封装的widget
class Refresh extends StatefulWidget {
  final Key key;

  const Refresh(this.key);

  @override
  _RefreshState createState() => _RefreshState();
}

class _RefreshState extends State<Refresh> {
  String text = "0";
  bool S = false;

  void onPressed(bool state) {
    setState((){
      S = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (S == true) { //錄音中
      print("Recorder State: true");
      return Icon(Icons.stop_outlined, size: 38);
    } else {
      print("Recorder State: false");
      return Icon(Icons.mic_outlined, size: 38);
    }
  }
}