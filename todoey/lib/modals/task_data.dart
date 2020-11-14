import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'task.dart';

//Used shared preferences as a temporary storage session

class TaskData extends ChangeNotifier {
  //List<String> is the only option suitable here
  List<String> taskNames = [];
  List<Task> tasks = [
    Task(name: 'Go to the Gym'),
    Task(name: 'Complete the Flutter Project'),
    Task(name: 'Read 20 Pages'),
  ];
  /*
  int get taskCount(){
  return tasks.length;
  }
   */
  //We can also use unmodifiable list to avoid direct adding to the tasks list
  void addTask(String taskTitle) async {
    tasks.add(Task(name: taskTitle));
    taskNames.add(taskTitle);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('key', taskNames);
    notifyListeners();
  }

  void updateCheck(Task task) {
    task.toggleCheck();
    notifyListeners();
  }

  void removeTask(Task task) async {
    tasks.remove(task);
    taskNames.remove(task.name);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //key can be anything just used to fetch the list
    await prefs.setStringList("key", taskNames);
    notifyListeners();
  }
}
