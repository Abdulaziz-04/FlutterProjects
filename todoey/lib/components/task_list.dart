import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modals/task_data.dart';
import 'task_tile.dart';

//This is used as stateful widget to pass on the data in the TaskTile and so on  without the Provider

class TaskList extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    //instead of using Provider.of(context) to access data we can use the Consumer Widget
    //Without Provider use widget.tasks to access the data
    return Consumer(
      builder: (context, TaskData taskData, child) {
        return ListView.builder(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            //store final task=taskData.tasks for better code
            return TaskTile(
                taskData.tasks[index].name, taskData.tasks[index].isChecked,
                (value) {
              taskData.updateCheck(taskData.tasks[index]);
              //without Provider
              /*setState(() {
                  taskData.tasks[index].toggleCheck();
                });*/
            }, () {
              taskData.removeTask(taskData.tasks[index]);
            });
          },
          itemCount: taskData.tasks.length,
        );
      },
    );
  }
}
