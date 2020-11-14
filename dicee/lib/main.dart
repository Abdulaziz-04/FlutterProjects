import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'dart:math';

AudioCache audioPlayer = AudioCache();

void main() {
  runApp(DiceApp());
}

class DiceApp extends StatefulWidget {
  @override
  _DiceAppState createState() => _DiceAppState();
}

class _DiceAppState extends State<DiceApp> {
  int leftDiceNum = 6, rightDiceNum = 6, colorIndex = 2;
  List colorTheme = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.grey,
    Colors.deepPurple
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: colorTheme[colorIndex][900],
        appBar: AppBar(
          backgroundColor: colorTheme[colorIndex][800],
          title: Center(
            child: Text(
              'Dicee',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 30.0,
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset('images/dice$leftDiceNum.png'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset('images/dice$rightDiceNum.png'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70.0,
            ),
            TextButton(
              onPressed: () {
                audioPlayer.play('MOREDICE.wav');
                setState(() {
                  leftDiceNum = Random().nextInt(6) + 1;
                  rightDiceNum = Random().nextInt(6) + 1;
                  colorIndex = Random().nextInt(6);
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    colorTheme[colorIndex][600]),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
                child: Container(
                  child: Text(
                    'Roll',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
