import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String name;
  final bool isChecked;
  final Function toggleTask;
  final Function deleteTask;
  TaskTile(this.name, this.isChecked, this.toggleTask, this.deleteTask);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: deleteTask,
      title: Text(
        name,
        style: TextStyle(
            fontSize: 22.0,
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        onChanged: toggleTask,
        activeColor: Colors.teal,
        value: isChecked,
      ),
    );
  }
}
