import 'file:///C:/Users/abdul/AndroidStudioProjects/bmi_calculator/lib/components/calculate_button.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage(this.bmi, this.result, this.advice);
  final String bmi, result, advice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'BMI Calculator',
            style: kbarStyle,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Your Result ',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 50.0),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(kinactiveColor),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: Text(
                      result,
                      style: TextStyle(
                        color:
                            result == "NORMAL" ? Color(0xff24d876) : Colors.red,
                        fontWeight: FontWeight.w900,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      bmi,
                      style: knumberStyle.copyWith(fontSize: 70.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      advice,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'Oswald',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CalculateButton(
            'RE-CALCULATE',
            () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
