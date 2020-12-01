import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoomScreen extends StatefulWidget {
  static String id = 'room_screen';
  //set the name of collection to be fetched from
  static String room;
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  //text controllers to clear inputs
  final sendText = TextEditingController();
  final _auth = FirebaseAuth.instance;

  //seperate card style selection
  Expanded roomCard(String roomName, String title) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          RoomScreen.room = roomName;
          Navigator.pushNamed(context, ChatScreen.id);
        },
        child: Card(
          color: Colors.lightBlueAccent,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Rubik', fontSize: 30.0),
            ),
          ),
        ),
      ),
    );
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
            },
          ),
        ],
        title: Text(
          'Chat',
          style: TextStyle(fontFamily: 'Rubik', fontSize: 25.0),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            roomCard('Messages', 'Let\'s Talk'),
            roomCard('Anime', ' Anime Discussion'),
            roomCard('Career(Discuss)', 'Career Discussion'),
            roomCard('Hangout', 'Hangout and Chill '),
            roomCard('Unpopular Opinion', 'Unpopular Opinion'),
            roomCard('Hobby Discussions', 'Hobby Discussions'),
            roomCard('Political Viewpoints', 'Political Viewpoints'),
          ],
        ),
      ),
    );
  }
}
