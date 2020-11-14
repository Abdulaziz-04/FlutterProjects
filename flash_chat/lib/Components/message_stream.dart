import 'package:flutter/material.dart';
import 'message_bubble.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/room_screen.dart';

User loggedInUser;
final _fireStore = FirebaseFirestore.instance;

//Message Stream gets updated and rebuilt for every additon on database
//can also be used as stateless widget
class MessageStream extends StatefulWidget {
  @override
  _MessageStreamState createState() => _MessageStreamState();
}

class _MessageStreamState extends State<MessageStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      //stream for the change analyzer
      stream: _fireStore
          .collection(RoomScreen.room)
          .orderBy('msgtime', descending: true)
          .snapshots(),
      //builder for each input added
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messageStream = snapshot.data.docs;
        List<Widget> messageWidgets = [];
        for (var msg in messageStream) {
          final message = msg.get('text');
          final sender = msg.get('sender');
          final Timestamp time = msg.get('msgtime');
          MessageBubble msgWidget = new MessageBubble(
              message,
              sender,
              loggedInUser.email == sender,
              DateFormat.Hm()
                  .format(
                    DateTime.fromMicrosecondsSinceEpoch(
                        time.microsecondsSinceEpoch),
                  )
                  .toString());
          messageWidgets.add(msgWidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            children: messageWidgets,
          ),
        );
      },
    );
  }
}
