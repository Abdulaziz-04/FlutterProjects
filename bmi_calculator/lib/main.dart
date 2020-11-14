import 'package:flutter/material.dart';
import 'screens/input_page.dart';
import 'constants.dart';

//Icons can be changed replacing files in given locations
// for android its android/app/src/main/res/*mipmaps
//for ios its inside the Runner Fodler

//Material App allows to use ReadyMade widgets
//Scaffold prepares the canvas to build the widgets
/*widgets can be treated as stateless class components
to modify certain properties pass them in constructors*/
//Stateless components are built only once and modified once only using the final variable
//themes can be used to modify the widgets upto a certain extent inheriting the basic properties
//Custom widgets can be created using more and more primitive versions of giver widgets
//Dealing with state requires Stateful components
//shortcuts stless,stful

void main() {
  runApp(BMICalc());
}

class BMICalc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(kbackGroundClr),
          scaffoldBackgroundColor: Color(kbackGroundClr),
        ),
        home: InputPage());
  }
}
