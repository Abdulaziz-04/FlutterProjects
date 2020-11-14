import 'dart:async';
import '../components/calculate_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'results_page.dart';
import '../calculate_bmi.dart';
import '../components/gender_card.dart';
import '../components/reusable_card.dart';
import '../constants.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text(
            "Please select your Gender",
            style: TextStyle(fontFamily: 'Oswald', fontSize: 20.0),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(
                  color: Color(kredColor),
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Timer timer;
  Gender selectedGender;
  int height = 180;
  int weight = 60;
  int age = 18;
  void longPressHandler(Function event) {
    timer = Timer.periodic(
      Duration(milliseconds: ktimeDelay),
      (t) {
        event();
      },
    );
  }

  void longPressDone() {
    timer.cancel();
  }

  void ageIncrement() {
    setState(
      () {
        if (age < 200) {
          age++;
        }
      },
    );
  }

  void ageDecrement() {
    setState(
      () {
        if (age > 1) {
          age--;
        }
      },
    );
  }

  void weightIncrement() {
    setState(
      () {
        if (weight < 600) {
          weight++;
        }
      },
    );
  }

  void weightDecrement() {
    setState(
      () {
        if (weight > 1) {
          weight--;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('BMI Calculator', style: kbarStyle),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    child: ReusableCard(
                      Color(selectedGender == Gender.male
                          ? kactiveColor
                          : kinactiveColor),
                      GenderCard(FontAwesomeIcons.mars, 'MALE'),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    child: ReusableCard(
                      Color(selectedGender == Gender.female
                          ? kactiveColor
                          : kinactiveColor),
                      GenderCard(
                        FontAwesomeIcons.venus,
                        'FEMALE',
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                      Color(kactiveColor),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'HEIGHT',
                            style: ktextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: <Widget>[
                              Text(
                                height.toString(),
                                style: knumberStyle,
                              ),
                              Text(' CM', style: kunitStyle),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              inactiveTrackColor: Color(ktextColor),
                              activeTrackColor: Colors.white,
                              overlayColor: Color(0x29eb1555),
                              thumbColor: Color(kredColor),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 15.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 30.0),
                            ),
                            child: Slider(
                              min: 100.0,
                              max: 220,
                              value: height.toDouble(),
                              onChanged: (double newVal) {
                                setState(
                                  () {
                                    height = newVal.round();
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    Color(kactiveColor),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: ktextStyle,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              weight.toString(),
                              style: knumberStyle,
                            ),
                            Text(
                              ' Kg',
                              style: kunitStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onLongPress: () {
                                longPressHandler(weightIncrement);
                              },
                              onLongPressEnd: (LongPressEndDetails det) {
                                longPressDone();
                              },
                              child: RoundIconButton(
                                  FontAwesomeIcons.plus, weightIncrement),
                            ),
                            SizedBox(
                              width: 40.0,
                            ),
                            GestureDetector(
                              onLongPress: () {
                                longPressHandler(weightDecrement);
                              },
                              onLongPressEnd: (LongPressEndDetails det) {
                                longPressDone();
                              },
                              child: RoundIconButton(
                                  FontAwesomeIcons.minus, weightDecrement),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    Color(kactiveColor),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: ktextStyle,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              age.toString(),
                              style: knumberStyle,
                            ),
                            Text(
                              ' y',
                              style: kunitStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onLongPress: () {
                                longPressHandler(ageIncrement);
                              },
                              onLongPressEnd: (LongPressEndDetails det) {
                                longPressDone();
                              },
                              child: RoundIconButton(
                                  FontAwesomeIcons.plus, ageIncrement),
                            ),
                            SizedBox(
                              width: 40.0,
                            ),
                            GestureDetector(
                              onLongPress: () {
                                longPressHandler(ageDecrement);
                              },
                              onLongPressEnd: (LongPressEndDetails det) {
                                longPressDone();
                              },
                              child: RoundIconButton(
                                  FontAwesomeIcons.minus, ageDecrement),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          CalculateButton('CALCULATE', () {
            if (selectedGender == null) {
              _showDialog();
              return;
            }
            CalculateResult calc = new CalculateResult(height, weight);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultsPage(
                  calc.calculate(),
                  calc.getResult(),
                  calc.getAdvice(),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton(this.icon, this.onPressed);
  final IconData icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      onPressed: onPressed,
      elevation: 6.0,
      fillColor: Color(0xff4c4f5e),
      constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
      shape: CircleBorder(),
    );
  }
}
