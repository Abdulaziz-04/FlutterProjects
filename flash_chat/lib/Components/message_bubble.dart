import '../screens/room_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class MessageBubble extends StatefulWidget {
  MessageBubble(this.text, this.sender, this.isMe, this.time);
  final String text, sender, time;
  final bool isMe;
  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  String text, sender, time;
  bool isMe;

  //Components were not rebuilt in stream so added this extra function
  @override
  void didUpdateWidget(MessageBubble oldWidget) {
    setState(() {
      text = widget.text;
      sender = widget.sender;
      time = widget.time;
      isMe = widget.isMe;
    });
    super.didUpdateWidget(oldWidget);
  }

  //Alert dialog
  void _showDialog(dialog) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Text(
            dialog,
            style: TextStyle(fontFamily: 'Rubik', fontSize: 18.0),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text(
                "Delete",
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () async {
                if (isMe == true) {
                  QuerySnapshot q = await _firestore
                      .collection(RoomScreen.room)
                      .where('text', isEqualTo: text)
                      .get();
                  Navigator.of(context).pop();
                  await q.docs.last.reference.delete();
                } else {
                  return;
                }
              },
            ),
            TextButton(
              child: Text(
                "Cancel",
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
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      text = widget.text;
      sender = widget.sender;
      time = widget.time;
      isMe = widget.isMe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          !isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: isMe
              ? Text('')
              : Text(
                  sender,
                  style: TextStyle(fontFamily: 'Rubik', color: Colors.blueGrey),
                ),
        ),
        GestureDetector(
          onLongPress: () {
            if (isMe == true) {
              _showDialog('Delete this message?');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: isMe
                      ? Color(0xfff5f5dc)
                      : Colors.lightBlueAccent.withOpacity(0.8),
                  borderRadius: !isMe
                      ? BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0))
                      : BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                child: EasyRichText(
                  '$text $time',
                  patternList: [
                    EasyRichTextPattern(targetString: '$time', subScript: true)
                  ],
                  defaultStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
