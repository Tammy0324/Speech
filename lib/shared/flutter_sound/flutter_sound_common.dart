import 'package:logger/logger.dart';

/// Flutter_sound log level
const Level fsLogLevel = Level.nothing; // set log level for flutter_sound: Level.info/debug/nothing, or ...

/// sample rate in general
const int fsSAMPLERATE_Low = 16000; // Non_PCM can only work on lower sample rate.
const int fsSAMPLERATE = 44100; // Doc say 44100 does not work for recorder on iOS, but tested work fine..

// slide position 0.0~1.0
double fsSliderCurrentPosition = 0.0;
double fsMaxDuration = 1.0;

// subscription duration milliseconds
const int fsRecorderSubDuration = 10;
const int fsPlayerSubDuration = 10;