import 'package:flutter/material.dart';
import '../modals/task_data.dart';
import 'package:provider/provider.dart';

String taskTitle;

class AddTask extends StatelessWidget {
  /*
 Without Provider
 AddTask(this.getNameCallback);
  final Function getNameCallback;
  */
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, TaskData taskData, child) {
        return Container(
          //set the background  transparent to get curved borders
          color: Color(0xff757575),
          child: Container(
            padding: EdgeInsets.all(30.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(32.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Add Task',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.teal),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  child: TextField(
                    onChanged: (value) {
                      taskTitle = value;
                    },
                    autofocus: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
                MaterialButton(
                  color: Colors.teal,
                  onPressed: () {
                    taskData.addTask(taskTitle);
                    Navigator.pop(context);
                    //getNameCallback(taskTitle);
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
