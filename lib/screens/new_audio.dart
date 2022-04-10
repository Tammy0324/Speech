import 'dart:async';
import 'dart:io'; // use to get Platform info & check file exist, can't use on web
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // only use kIsWeb
// import 'package:intl/intl.dart';

// flutter_sound common code + recorder + player
import 'package:project/shared/flutter_sound/flutter_sound_common.dart'; // the common part of flutter_sound
import 'package:project/shared/flutter_sound/flutter_sound_record.dart'; // the recording part of flutter_sound
import 'package:project/shared/flutter_sound/flutter_sound_play.dart'; // the player part of flutter_sound
import 'package:project/shared/flutter_sound/flutter_sound_audio_platform_base.dart';// 稻草人 scarecrow
// if (dart.library.io) 'package:happy_recorder/shared/flutter_sound/flutter_sound_audio_platform_mobile.dart' // real mobile default Codec
// if (dart.library.js) 'package:happy_recorder/shared/flutter_sound/flutter_sound_audio_platform_web.dart'; // real web default codec

/// Happy recorder - record audio into FILE only.
String _recorderTxt = '00:00:00'; // work for all language, no need to translate.
String _playerTxt = '00:00:00';
double? _dbLevel; // volume
bool? _encoderSupported = true; // Optimist, assuming Codec supported
bool _decoderSupported = true; // Optimist, assuming Codec supported
double? _duration; // Estimated audio length, uses FFmpeg, just an estimation, based on the Codec used and the sample rate.
Codec _codec = FSAudioPlatform().defaultCodec; /// codec default, set via flutter_sound_audio_platform_xxx, safari(MP4)/non-safari(WebM)/non-Web(pcm16WAV)

/// set the file name, later will allow user input
final String defaultFileName = "HappyAudio";

class S {
  static S of(BuildContext context) => S.of(context);
  String get new_audio_microphone_permission_not_granted => "new_audio_microphone_permission_not_granted";
  String get new_audio_codec => "new_audio_codec";
  String get new_audio_codec_loading_error => "new_audio_codec_loading_error";
  String get new_audio_codec_loading => "new_audio_codec_loading";
  String get new_audio_AppBar => "new_audio_AppBar";
}


class NewAudio extends StatefulWidget {
  // final int ArIndex;
  const NewAudio({Key? key}) : super(key: key);

  @override
  _NewAudioState createState() => _NewAudioState();
}

class _NewAudioState extends State<NewAudio> {
  bool _isRecording = false; // initial recording status to not recording.
  String? _path; // file path name, not explicitly initialized = null.
  String _recMsg = ""; // recoding message or audio file name.
  Future<List<Codec>>? _supportedCodec; // used future builder

  // initial
  Future<void> init() async {
    await fsInitializeRecorder();
    await fsInitializePlayer(false);
    await setCodec(_codec);
    _supportedCodec = platformSupportedCodec(); // Supported Codecs list, a future
  }

  // get supported codec
  Future<List<Codec>>platformSupportedCodec() async {
    List<Codec> _supported=[];
    for (var _codecX in Codec.values) {
      // skip default codec which its ext is ""
      if ( (ext[_codecX.index] != "")
          && (await recorderModule.isEncoderSupported(_codecX))
          && (await playerModule.isDecoderSupported(_codecX)) ) {
        _supported.add(_codecX);
      }
    }
    return _supported;
  }

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
      _recMsg = '$defaultFileName${ext[_codec.index]}'; // recoding message = file name
      if (!kIsWeb) {
        var tempDir = await getTemporaryDirectory(); // need path_provider package
        path = '${tempDir.path}/$_recMsg';
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
      recorderModule.logger.d('startRecorder *happy*');

      // onProgress is a stream to post recorder status. api: https://tau.canardoux.xyz/tau_api_recorder_on_progress.html
      fsRecorderSubscription = recorderModule.onProgress!.listen((e) {
        var date = DateTime.fromMillisecondsSinceEpoch(
            e.duration.inMilliseconds,
            isUtc: true);
       // var txt = DateFormat('mm:ss:SS', 'en_US').format(date);

        setState(() {
          //_recorderTxt = txt.substring(0, 8);
          _dbLevel = e.decibels; // Volume value ranges from 0 to 120
        });
      });

      setState(() {
        _isRecording = true;
        _path = path;
      });
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
  }

  // get audio duration: (Web not work, its _duration = null)
  Future<void> getDuration() async {
    var path = _path;
    var d = path != null ? await flutterSoundHelper.duration(path) : null;
    _duration = d != null ? d.inMilliseconds / 1000.0 : null;
    setState(() {});
  }

  void stopRecorder() async {
    try {
      await recorderModule.stopRecorder();
      recorderModule.logger.d('stopRecorder');
      fsCancelRecorderSubscriptions();
      await getDuration();
    } on Exception catch (err) {
      recorderModule.logger.d('stopRecorder error: $err');
    }
    setState(() {
      _isRecording = false;
    });
  }

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
  }

  void Function()? onPauseResumeRecorderPressed() {
    if (recorderModule.isPaused || recorderModule.isRecording) {
      return pauseResumeRecorder;
    }
    return null;
  }

  void startStopRecorder() {
    if (recorderModule.isRecording || recorderModule.isPaused) {
      stopRecorder();
    } else {
      startRecorder();
    }
  }

  void Function()? onStartRecorderPressed() {
    if (!_encoderSupported!) return null; // null: disable the button when selected codec not supported
    return startStopRecorder;
  }

  Icon recorderIcon() {
    if (onStartRecorderPressed() == null) {
      return Icon(Icons.mic_off_outlined);
    }
    return (recorderModule.isStopped)
        ? Icon(Icons.mic_outlined)
        : Icon(Icons.stop_outlined);
  }

  Future<void> setCodec(Codec codec) async {
    _encoderSupported = await recorderModule.isEncoderSupported(codec);
    _decoderSupported = await playerModule.isDecoderSupported(codec);
    setState(() {
      _codec = codec;
    });
  }

  /// player
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
      // var txt = DateFormat('mm:ss:SS', 'en_US').format(date);
      setState(() {
        //_playerTxt = txt.substring(0, 8);
      });
    });
  }

  Future<void> startPlayer() async {
    try {
      String? audioFilePath;

      if (kIsWeb || await File(_path!).exists() ) { // if not web, check file exists?
        audioFilePath = _path;
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
  }

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
  }

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
  }

  // start/pause/resume Player 3-in-1
  void Function()? onStartPauseResumePlayerPressed() {
    if (_path == null) return null; // no file, not able play, disable btn
    // selected codec is not supported, disable btn
    /// why force Codec.pcm16 always = enabled?
    if (!(_decoderSupported || _codec == Codec.pcm16)) return null;
    if (playerModule.isStopped) return startPlayer;
    if (playerModule.isPaused || playerModule.isPlaying) return pauseResumePlayer;

    return null; // catch all, just disable btn
  }

  void Function()? onStopPlayerPressed() {
    return (playerModule.isPlaying || playerModule.isPaused)
        ? stopPlayer
        : null;
  }

  Future<void> seekToPlayer(int milliSecs) async {
    //playerModule.logger.d('-->seekToPlayer');
    try {
      if (playerModule.isPlaying) {
        await playerModule.seekToPlayer(Duration(milliseconds: milliSecs));
      }
    } on Exception catch (err) {
      playerModule.logger.e('error: $err');
    }
    setState(() {});
  }

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

  @override
  Widget build(BuildContext context) {

    // Codec Selection
    Widget futureCodecSelect = FutureBuilder<List<Codec>>(
      future: _supportedCodec,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      S.of(context).new_audio_codec,
                      style: Theme.of(context).textTheme.bodyText2!
                          .apply(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
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
              child: Center(
                  child: Text(
                    S.of(context).new_audio_codec_loading_error,
                    style: Theme.of(context).textTheme.bodyText2!
                        .apply(color: Theme.of(context).colorScheme.primary),
                  )
              )
          );
        } else {
          return Container(
              height: 50,
              child: Center(
                  child: Text(
                    S.of(context).new_audio_codec_loading,
                    style: Theme.of(context).textTheme.bodyText2!
                        .apply(color: Theme.of(context).colorScheme.primaryVariant),
                  )
              )
          );
        }
      },
    );

    // Recorder
    Widget recorderSection = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 12.0, bottom: 3.0),
            child: Text(
              _recorderTxt,
              style: Theme.of(context).textTheme.headline5!
                  .apply(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.0, bottom: 6.0),
            child: Text(
              _recMsg,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          (_isRecording && !kIsWeb) /// Flutter_sound not support web recording volume
              ? Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          ? Icon(Icons.arrow_right_outlined)
                          : Icon(Icons.pause_outlined))
                          : Container()),
                ),
              ),
            ],
          ),
        ]);

    // Player
    Widget playerSection = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 12.0, bottom: 16.0),
          child: Text(
            _playerTxt,
            style: Theme.of(context).textTheme.headline5!.apply(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 56.0,
              height: 50.0,
              child: ClipOval(
                child: TextButton(
                    onPressed: onStartPauseResumePlayerPressed(),
                    child: (playerModule.isStopped || playerModule.isPaused)
                        ? Icon(Icons.play_arrow_outlined)
                        : Icon(Icons.pause_outlined)),
              ),
            ),
            Container(
              width: 56.0,
              height: 50.0,
              child: ClipOval(
                child: TextButton(
                    onPressed: onStopPlayerPressed(),
                    child: (playerModule.isPlaying || playerModule.isPaused)
                        ? Icon(Icons.stop_outlined)
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
        Container(
          height: 30.0,
          child: Text('null'),
          // child: Text(_duration != null ? S.of(context).new_audio_duration( new NumberFormat.compact().format(_duration)) : ''),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(S.of(context).new_audio_AppBar),
      ),
      body: ListView(
        children: <Widget>[
          kIsWeb ? Container() : futureCodecSelect, /// codec selection, disabled on Web.
          recorderSection, // recording
          playerSection, // player
        ],
      ),
    );
  }
}