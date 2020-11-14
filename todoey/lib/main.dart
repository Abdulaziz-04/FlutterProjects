import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modals/task_data.dart';
import 'screens/tasks_screen.dart';

//Provider is always added to the parent of the widget where it is required

void main() {
  runApp(ToDoey());
}

class ToDoey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
      create: (context) => new TaskData(),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
