import 'package:audioplayers/audioplayers.dart';

AudioCache player = AudioCache();

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  player.play('voice/example.mp3');
  }