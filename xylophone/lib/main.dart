import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

AudioCache audioPlayer = AudioCache();
void main() {
  runApp(XylophoneApp());
}

void playSound(int soundNum) {
  audioPlayer.play('note$soundNum.wav');
}

Expanded buildKey({Color col, int soundNum}) {
  return Expanded(
    child: MaterialButton(
      enableFeedback: false,
      color: col,
      onPressed: () => playSound(soundNum),
    ),
  );
}

class XylophoneApp extends StatefulWidget {
  @override
  _XylophoneAppState createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildKey(col: Colors.red, soundNum: 1),
              buildKey(col: Colors.orange, soundNum: 2),
              buildKey(col: Colors.yellow, soundNum: 3),
              buildKey(col: Colors.greenAccent, soundNum: 4),
              buildKey(col: Colors.blue, soundNum: 5),
              buildKey(col: Colors.teal, soundNum: 6),
              buildKey(col: Colors.purple, soundNum: 7),
            ],
          ),
        ),
      ),
    );
  }
}
