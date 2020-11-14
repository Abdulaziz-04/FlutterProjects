import 'room_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../rounded_buttons.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final emailText = TextEditingController();
  final pwdText = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String email, pwd;

  void clearFields() {
    emailText.clear();
    pwdText.clear();
  }

  void _showDialog(text) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Text(
            text,
            style: TextStyle(fontFamily: 'Rubik', fontSize: 18.0),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text(
                "Close",
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
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

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image(
                        image: AssetImage('images/logo.png'),
                        height: 200.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextField(
                  controller: emailText,
                  style: TextStyle(fontSize: 20.0),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration:
                      kinputField.copyWith(hintText: 'Enter your Email'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: pwdText,
                  style: TextStyle(fontSize: 20.0),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    pwd = value;
                  },
                  decoration:
                      kinputField.copyWith(hintText: 'Enter your Password'),
                ),
                RoundedButton(
                  Colors.lightBlueAccent,
                  'LogIn',
                  () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: pwd);
                      clearFields();
                      if (user != null) {
                        Navigator.pushNamed(context, RoomScreen.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      _showDialog(e.toString());
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
