import 'package:flutter/material.dart';
import 'home_screen.dart';

const bgColor = 0xff101820;
void main() {
  runApp(TickerApp());
}

class TickerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(bgColor),
      ),
      home: HomeScreen(),
    );
  }
}
