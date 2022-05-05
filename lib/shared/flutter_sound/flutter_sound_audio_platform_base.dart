import 'package:flutter_sound/flutter_sound.dart';

class FSAudioPlatform {
  // 這是假的稻草人設定，a stub
  // 真的 mobile 設定在 flutter_sound_audio_platform_mobile,
  // 真的 web 設定在 flutter_sound_audio_platform_web,
  Codec defaultCodec = Codec.aacADTS; // this setting will be overrode by platform (mobile/web)
}