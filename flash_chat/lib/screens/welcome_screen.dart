import 'package:animated_text_kit/animated_text_kit.dart';
import '../rounded_buttons.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'package:flutter/material.dart';

//final variables can be changed once and decided on runtime only
class WelcomeScreen extends StatefulWidget {
  //naming all routes to access them via string
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  //single ticker mixin allows one ticking animation
  //wait boolean for the flash animation to complete
  bool wait = true;
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    //Use custom animation
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutCubic);
    //listen to let the flash animation complete
    animation.addStatusListener((status) {
      if (animation.status == AnimationStatus.completed) {
        setState(() {
          wait = false;
        });
      }
    });
    //move forward
    controller.forward();
    //add Listener
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Flash ',
                  style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik',
                    fontSize: 50,
                  ),
                ),
                //Inbuilt Animation
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                      child: Image(
                        image: AssetImage('images/logo.png'),
                        height: animation.value * 120,
                        //can use controller.value for certain animations
                      ),
                    ),
                  ),
                ),
                Text(
                  'Chat',
                  style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik',
                    fontSize: 40,
                  ),
                ),
              ],
            ),
            wait
                ? Text('')
                : TypewriterAnimatedTextKit(
                    displayFullTextOnTap: true,
                    totalRepeatCount: 1,
                    text: ['Instant Messenger !'],
                    speed: Duration(milliseconds: 150),
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rubik',
                      fontSize: 18.0,
                    ),
                  ),
            SizedBox(
              height: 30.0,
            ),
            //Seperate Stateless class for the elements
            MainRoundedButton(
              Colors.lightBlueAccent,
              'LogIn',
              () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            MainRoundedButton(
              Colors.indigo,
              'Register',
              () {
                Navigator.pushNamed(context, RegisterScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
