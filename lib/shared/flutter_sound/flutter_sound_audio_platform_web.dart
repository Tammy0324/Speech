import 'package:platform_detect/platform_detect.dart' show browser;
import 'package:flutter_sound/flutter_sound.dart';

class FSAudioPlatform {
  // in Browser now, set default code, Safari = aac, other = WebM
  Codec defaultCodec = (browser.isSafari) ? Codec.aacMP4 : Codec.opusWebM;
}