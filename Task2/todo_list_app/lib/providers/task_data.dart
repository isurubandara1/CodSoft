import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(String title) {
    _tasks.add(Task(title: title));
    notifyListeners();
  }

  void updateTask(Task task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
