import 'room_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../rounded_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController textController;
  final emailText = TextEditingController();
  final pwdText = TextEditingController();
  bool showSpinner = false;
  String email, pwd;
  final _auth = FirebaseAuth.instance;
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
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    pwd = value;
                  },
                  decoration:
                      kinputField.copyWith(hintText: 'Enter your Password'),
                ),
                RoundedButton(
                  Colors.indigo,
                  'Register',
                  () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: pwd);
                      clearFields();
                      if (newUser != null) {
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
