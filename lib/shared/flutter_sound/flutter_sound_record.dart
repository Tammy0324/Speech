import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:project/shared/flutter_sound/flutter_sound_common.dart';

StreamSubscription fsRecorderSubscription;
FlutterSoundRecorder recorderModule = FlutterSoundRecorder(logLevel: fsLogLevel);

// initial Recording & subscript status
Future<void> fsInitializeRecorder() async {
  await recorderModule.openAudioSession(
    // https://tau.canardoux.xyz/pages/flutter-sound/api/recorder/FlutterSoundRecorder/openAudioSession.html
      focus: AudioFocus.requestFocusAndStopOthers, // exclusive, ref: https://tau.canardoux.xyz/tau_api_player_open_audio_session.html#focus-parameter
      category: SessionCategory.playAndRecord, // ambient/playback/record/...
      mode: SessionMode.modeDefault, // ios audio mode: https://developer.apple.com/documentation/avfaudio/avaudiosessionmode
      device: AudioDevice.speaker); // output, for android, headset/blueTooth/airPlay...
  await recorderModule.setSubscriptionDuration(Duration(milliseconds: fsRecorderSubDuration));
}

// cancel recorder status subscription
void fsCancelRecorderSubscriptions() {
  if (fsRecorderSubscription != null) {
    fsRecorderSubscription.cancel();
    fsRecorderSubscription = null;
  }
}

// release all Flutter_sound package's recorder session.
Future<void> fsReleaseFlutterSoundRecorderSession() async {
  try {
    await recorderModule.closeAudioSession();
  } on Exception {
    recorderModule.logger.e('Released unsuccessful');
  }
}