import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/abdul/AndroidStudioProjects/todoey/lib/modals/task_data.dart';
import 'file:///C:/Users/abdul/AndroidStudioProjects/todoey/lib/components/task_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_task.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  void fetchTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('key') != null) {
      //add all tasks from prefs to create Task objects
      for (String names in prefs.getStringList('key')) {
        Provider.of<TaskData>(context, listen: false).addTask(names);
      }
    }
    prefs.clear();
  }

  //List of tasks is inserted here without the provider package
  //build external widgets
  /* Widget buildBottomSheet(BuildContext context) {
    return Container();
  }
  */
  @override
  void initState() {
    super.initState();
    //on every new load
    fetchTasks();

    // Add code after super
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  /*
                  Without Provider (Drop down from TaskTile)
                  return AddTask((taskTitle) {
                   Without using the Provider package
                   setState(() {
                      tasks.add(Task(name: taskTitle));
                    });
                    Navigator.pop(context);
                  });
                   */
                  return AddTask();
                });
          },
          backgroundColor: Colors.teal,
          child: Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 30.0, 0, 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 35.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.list,
                      color: Colors.teal,
                      size: 40.0,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    height: 100.0,
                    child: WavyAnimatedTextKit(
                      text: ['ToDoey'],
                      isRepeatingAnimation: false,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40.0),
                    ),
                  ),
                  Text(
                    //Use tasks.length where tasks is used in the tasks_screen widget
                    '${Provider.of<TaskData>(context).tasks.length} tasks',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 20.0),
                  child: ListView(
                    children: <Widget>[
                      TaskList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
