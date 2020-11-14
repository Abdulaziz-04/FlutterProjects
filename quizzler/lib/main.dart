import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'questionbank.dart';

const themeColord = 0xff00203f;
const themeColorl = 0xffadefd1;
AudioCache audioPlayer = AudioCache();
void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizApp(),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int correctCount = 0, incorrectCount = 0, total = 0;
  QuestionBank question = new QuestionBank();
  List<Expanded> scoreCard = [];
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Color(themeColord),
          content: Text(
            "Quiz Complete!",
            style: TextStyle(
                color: Colors.white, fontFamily: 'Lobster', fontSize: 20.0),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: Text(
                "Retry",
                style: TextStyle(
                    color: Color(themeColorl),
                    fontFamily: 'Lobster',
                    fontSize: 20.0),
              ),
              onPressed: () {
                //Remove the alert and previous page
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizApp(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void checkAnswer(bool ans) {
    total = correctCount + incorrectCount;
    if (total > 12) {
      _showDialog();
      return;
    } else {
      if (question.getAnswer() == ans) {
        audioPlayer.play('correct.mp3');
        correct();
      } else {
        audioPlayer.play('wrong.mp3');
        inCorrect();
      }
    }
    question.nextQuestion();
  }

  void correct() {
    setState(
      () {
        correctCount++;
        scoreCard.add(
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Icon(
                Icons.check,
                size: 35.0,
                color: Colors.greenAccent,
              ),
            ),
          ),
        );
      },
    );
  }

  void inCorrect() {
    setState(
      () {
        incorrectCount++;
        scoreCard.add(
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Icon(
                Icons.close,
                size: 35.0,
                color: Colors.redAccent,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(themeColord),
      appBar: AppBar(
        backgroundColor: Color(themeColorl),
        title: Center(
          child: Text(
            'Quizzler',
            style: TextStyle(
                fontFamily: 'Lobster', fontSize: 30.0, color: Colors.black),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Correct : $correctCount',
                  style: TextStyle(
                    fontFamily: 'Lobster',
                    color: Colors.greenAccent,
                    fontSize: 30.0,
                  ),
                ),
                Text(
                  'InCorrect : $incorrectCount',
                  style: TextStyle(
                    fontFamily: 'Lobster',
                    color: Colors.redAccent,
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    question.getQuestion(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lobster',
                        fontSize: 25.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 80.0, vertical: 15.0),
                child: MaterialButton(
                  onPressed: () {
                    checkAnswer(true);
                  },
                  color: Color(0xffadefd1),
                  child: Text(
                    'True',
                    style: TextStyle(fontSize: 30.0, fontFamily: 'Lobster'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 80.0, vertical: 15.0),
                child: MaterialButton(
                  onPressed: () {
                    checkAnswer(false);
                  },
                  color: Color(0xffadefd1),
                  child: Text(
                    'False',
                    style: TextStyle(fontSize: 30.0, fontFamily: 'Lobster'),
                  ),
                ),
              ),
            ),
            Row(
              children: scoreCard,
            ),
          ],
        ),
      ),
    );
  }
}
