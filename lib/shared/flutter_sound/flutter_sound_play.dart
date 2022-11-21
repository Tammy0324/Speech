import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:project/shared/flutter_sound/flutter_sound_common.dart';

StreamSubscription fsPlayerSubscription;
FlutterSoundPlayer playerModule = FlutterSoundPlayer(logLevel: fsLogLevel);

// initial player & subscript status
Future<void> fsInitializePlayer(bool withUI) async {
  await playerModule.closeAudioSession();
  await playerModule.openAudioSession(
    // withUI: Play data from a track specification and display controls on the lock screen or an Apple Watch.
    // we are not using it.
      withUI: withUI, // true if the App plan to use closeAudioSession later, and to control your App from the lock-screen
      focus: AudioFocus.requestFocusAndStopOthers, // What to do with others App if they have already the Focus
      category: SessionCategory.playAndRecord, // ios https://developer.apple.com/documentation/avfaudio/avaudiosessioncategory?preferredLanguage=occ
      mode: SessionMode.modeDefault, // ios https://developer.apple.com/documentation/avfaudio/avaudiosessionmode?preferredLanguage=occ
      device: AudioDevice.speaker); // headset/blueTooth/airPlay...
  await playerModule.setSubscriptionDuration(Duration(milliseconds: fsPlayerSubDuration));
}

// cancel player status subscription
void fsCancelPlayerSubscriptions() {
  if (fsPlayerSubscription != null) {
    fsPlayerSubscription.cancel();
    fsPlayerSubscription = null;
  }
}

// release all Flutter_sound package's player session.
Future<void> fsReleaseFlutterSoundPlayerSession() async {
  try {
    await playerModule.closeAudioSession();
  } on Exception {
    playerModule.logger.e('Released unsuccessful');
  }
}