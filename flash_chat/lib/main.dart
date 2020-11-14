/*
All Packages brief Intro
material for the material UI
firebase core for the initialization of the firebase components
firestore cloud to access the database
firebase auth for firevbase user  authentication
richtext for superscript subscript of texts
modalprogessHUD for loading screens
animated text kit for prebuit reeadymade animations
intl for dateformatting
flutter ringtone for default norification sounds
 */

/*
FEATURES WHICH CAN BE FURTHER IMPLEMENTED

Notifications using firebase messaging
refer :https://medium.com/@SebastianEngel/easy-push-notifications-with-flutter-and-firebase-cloud-messaging-d96084f5954f

Ability to edit messages

Ability to create more rooms

Better UI

Adding Attachments

Adding usernames

Adding avatars

Adding profile info

Show if user is typing..

Room privileges

 */

import 'screens/room_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/welcome_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        RoomScreen.id: (context) => RoomScreen(),
      },
    );
  }
}
