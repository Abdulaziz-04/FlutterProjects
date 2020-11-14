import 'package:flutter/material.dart';
import 'room_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Components/message_stream.dart';

final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final sendText = TextEditingController();
  bool isMe;
  String message;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    try {
      final user = _auth.currentUser;
      print(user);
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(
          RoomScreen.room,
          style: TextStyle(fontFamily: 'Rubik', fontSize: 25.0),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: TextField(
                      controller: sendText,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: InputDecoration(
                          focusColor: Colors.lightBlueAccent,
                          hintText: 'Enter your message..'),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    FlutterRingtonePlayer.playNotification();
                    _fireStore.collection(RoomScreen.room).add({
                      'text': message,
                      'sender': loggedInUser.email,
                      'msgtime': DateTime.now(),
                    });
                    sendText.clear();
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
