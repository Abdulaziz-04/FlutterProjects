import 'package:flutter/material.dart';
import '../constants.dart';

class CalculateButton extends StatelessWidget {
  CalculateButton(this.label, this.onPress);
  final Function onPress;
  final String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        color: Color(kredColor),
        height: 70.0,
        width: double.infinity,
        margin: EdgeInsets.only(top: 10.0),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 30.0, fontFamily: 'Oswald'),
          ),
        ),
      ),
    );
  }
}
